Feature: Testing the react Conduit-API for create an article

  Background:
    * url baseUrl
    * def token = authInfo.accessToken

  @createNewArticle
  Scenario: Create a new article

    * def article = read('classpath:abmarticle/abmNewArticleRequest.json')

    Given path 'articles'
    And request article
    And header Authorization = token
    When method post
    Then status 200
    And match response == read('classpath:abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == article['article']['title']
    And assert response.article['description'] == article['article']['description']
    And assert response.article['body'] == article['article']['body']
    And def addedArticleSlug = response.article['slug']
    And def getActualArticles = call read('getArticles.feature@getAllArticles')
    And def addedArticle = karate.jsonPath(getActualArticles.response, "$.articles[?(@.slug=='" + addedArticleSlug + "')]")
    And def responseArticle = karate.jsonPath(response, "$.article[?(@.slug=='" + addedArticleSlug + "')]")
    And assert addedArticle[0].title == response.article.title
    And assert addedArticle[0].body == response.article.body
    And assert addedArticle[0].description == response.article.description
