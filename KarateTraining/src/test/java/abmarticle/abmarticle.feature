Feature: Testing the react herokuapp for creation , modification and removal

  Background:
    * url baseUrl
    * def token = authInfo.accessToken

    ##* callonce read('classpath:src/test/java/signintask/signin.feature@postSignInUser')
    ##* def token = response.user.token

  @CreateNewArticle
  Scenario: Create a new article

    * def article = read('classpath:abmarticle/abmNewArticleRequest.json')
    ##* def signIn = call read('classpath:src/test/java/signintask/signin.feature@postSignInUser')

    Given path 'articles'
    And request article
    And header Authorization = 'Bearer ' + token
    When method post
    Then status 200
    Then match response == read('classpath:abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == article['article']['title']
    And assert response.article['description'] == article['article']['description']
    And assert response.article['body'] == article['article']['body']
    And def getActualArticles = call read('classpath:java/abmarticleutils/abmarticleutils.feature@getAllUsers')
    And assert getActualArticles.response.articles[0].title == response.article['title']
    And assert getActualArticles.response.articles[0].body == response.article['body']
    And assert getActualArticles.response.articles[0].description == response.article['description']


  @putAUser
  Scenario Outline: Put a new article in a specific slug

    * def article = read('classpath:abmarticle/abmPutArticleRequest.json')
    * def getArticles = call read('classpath:java/abmarticleutils/abmarticleutils.feature@getAllUsers')

    Given path 'articles', <slug>
    And request article
    And header Authorization = 'Bearer ' + token
    When method put
    Then status 200
    Then match response == read('classpath:abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == article['article']['title']
    And assert response.article['description'] == article['article']['description']
    And assert response.article['body'] == article['article']['body']
    And def getActualArticles = call read('classpath:java/abmarticleutils/abmarticleutils.feature@getAllUsers')
    And assert getActualArticles.response.articles[0].title == response.article['title']
    And assert getActualArticles.response.articles[0].body == response.article['body']
    And assert getActualArticles.response.articles[0].description == response.article['description']
    Then call read('classpath:java/abmarticleutils/abmarticleutils.feature@returnArticleToOriginal')

    Examples:
    |slug                                   |
    |getArticles.response.articles[0].slug  |