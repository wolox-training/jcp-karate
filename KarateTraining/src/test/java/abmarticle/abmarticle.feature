Feature: Testing the react Conduit-API for creation and modification

  Background:
    * url baseUrl
    * def token = authInfo.accessToken

  @createAndUpdateAnArticle
  Scenario: Create and update a new article

    * def createANewArticle = call read('abmCreateArticle.feature@createNewArticle')
    * def newArticleResponseSlug = createANewArticle.response.article.slug
    * def article = read('classpath:resources/abmarticle/abmPutArticleRequest.json')

    Given path 'articles', newArticleResponseSlug
    And request article
    And header Authorization = token
    When method put
    Then status 200
    And match response == read('classpath:resources/abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == article['article']['title']
    And assert response.article['description'] == article['article']['description']
    And assert response.article['body'] == article['article']['body']
    And def updatedArticleSlug = response.article['slug']
    And def getActualArticles = karate.call('getArticles.feature@getArticleBySlug', {'slug': updatedArticleSlug})
    And def updatedArticle = karate.jsonPath(getActualArticles.response, "$.articles[?(@.slug=='" + updatedArticleSlug + "')]")
    And assert updatedArticle[0].title == response.article.title
    And assert updatedArticle[0].body == response.article.body
    And assert updatedArticle[0].description == response.article.description
