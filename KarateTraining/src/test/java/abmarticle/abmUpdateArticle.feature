Feature: Testing the react Conduit-API for create an article

  Background:
    * url baseUrl
    * def token = authInfo.accessToken

  @putARandomUser
  Scenario Outline: Put a new article in a random slug

    * def getArticles = call read('getArticles.feature@getAllArticles')
    * def randomIndex = karate.call('classpath:src/test/RandomIndexGenerator.js', [getArticles.response['articles'].length])

    Given path 'articles', <slug>
    And request <article>
    And header Authorization = token
    When method put
    Then status 200
    And match response == read('classpath:abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == <article>['title']
    And assert response.article['description'] == <article>['description']
    And assert response.article['body'] == <article>['body']
    And def updatedArticleSlug = response.article['slug']
    And def getArticleBySlug = karate.call('getArticles.feature@getArticleBySlug', {'slug': updatedArticleSlug})
    And assert getArticleBySlug.response.article.title == response.article.title
    And assert getArticleBySlug.response.article.body == response.article.body
    And assert getArticleBySlug.response.article.description == response.article.description

    @putARandomArticle
    Examples:
    |slug                                            | article                                                          |
    |getArticles.response.articles[randomIndex].slug | read('classpath:resources/abmarticle/abmPutArticleRequest.json') |

    @putToOriginalArticle
    Examples:
    |slug                                            | article                                    |
    |getArticles.response.articles[randomIndex].slug | getArticles.response.articles[randomIndex] |
