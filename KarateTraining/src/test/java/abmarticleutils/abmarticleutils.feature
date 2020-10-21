Feature: Testing the react herokuapp for util services

  Background:
    * url baseUrl
    * def token = authInfo.accessToken

  @returnArticleToOriginal
  Scenario Outline: return an article to original with a specific slug

    * def article = read('classpath:abmarticle/abmNewArticleRequest.json')
    * def getArticles = call read('classpath:java/abmarticleutils/abmarticleutils.feature@getAllUsers')

    Given path 'articles', <slug>
    * print ("SLUG", <slug>)
    And request article
    And header Authorization = 'Bearer ' + token
    When method put
    Then status 200
    Then match response == read('classpath:abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == article['article']['title']
    And assert response.article['description'] == article['article']['description']
    And assert response.article['body'] == article['article']['body']


    Examples:
    |slug                                   |
    |getArticles.response.articles[0].slug  |


  @getAllUsers
  Scenario: Get all the articles from articles list

    Given path 'articles'
    When method get
    Then status 200