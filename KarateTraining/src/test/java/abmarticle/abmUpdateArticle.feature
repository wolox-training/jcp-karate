Feature: Testing the react Conduit-API for create an article

  Background:
    * url baseUrl
    * def token = authInfo.accessToken

  @putARandomUser
  Scenario Outline: Put a new article in a specific slug

    * def getArticles = call read('getArticles.feature@getAllArticles')
    * def randomIndex = karate.call('classpath:src/test/RandomIndexGenerator.js', [getArticles.response['articles'].length])

    Given path 'articles', <slug>
    And request <article>
    And header Authorization = token
    When method put
    Then status 200
    And match response == read('classpath:abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == <article>['article']['title']
    And assert response.article['description'] == <article>['article']['description']
    And assert response.article['body'] == <article>['article']['body']
    And def updatedArticleSlug = response.article['slug']
    And def getActualArticles = karate.call('getArticles.feature@getArticleBySlug', {'slug': updatedArticleSlug})
    And def updatedArticle = karate.jsonPath(getActualArticles.response, "$.articles[?(@.slug=='" + updatedArticleSlug + "')]")
    And assert updatedArticle[0].title == response.article.title
    And assert updatedArticle[0].body == response.article.body
    And assert updatedArticle[0].description == response.article.description

    @putARandomArticle
    Examples:
    |slug                                            | article                                                          |
    |getArticles.response.articles[randomIndex].slug | read('classpath:resources/abmarticle/abmPutArticleRequest.json') |

    @putToOriginalArticle
    Examples:
    |slug                                            | article                                                          |
    |getArticles.response.articles[randomIndex].slug | read('classpath:resources/abmarticle/abmNewArticleRequest.json') |
