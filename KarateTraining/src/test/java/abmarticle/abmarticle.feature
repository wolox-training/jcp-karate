Feature: Testing the react herokuapp for creation , modification and removal

  Background:
    * url baseUrl
    * def token = authInfo.accessToken

  @CreateNewArticle
  Scenario: Create a new article

    * def article = read('classpath:abmarticle/abmNewArticleRequest.json')

    Given path 'articles'
    And request article
    And header Authorization = token
    When method post
    Then status 200
    Then match response == read('classpath:abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == article['article']['title']
    And assert response.article['description'] == article['article']['description']
    And assert response.article['body'] == article['article']['body']
    And def getActualArticles = call read('abmarticle.feature@getAllArticles')
    And def addedArticle = karate.jsonPath(getActualArticles.response, "$.articles[?(@.title=='" + article['article'].title + "')]")[0]
    And assert addedArticle.title == response.article['title']
    And assert addedArticle.body == response.article['body']
    And assert addedArticle.description == response.article['description']


  @putAUser
  Scenario Outline: Put a new article in a specific slug

    * def getArticles = call read('abmarticle.feature@getAllArticles')
    * def random = function(max) { return Math.floor(Math.random() * max) + 1}
    * def randomIndex = random (getArticles.response['articles'].length)

    Given path 'articles', <slug>
    And request <article>
    And header Authorization = token
    When method put
    Then status 200
    Then match response == read('classpath:abmarticle/abmNewArticleResponseSchema.json')
    And assert response.article['title'] == <article>['article']['title']
    And assert response.article['description'] == <article>['article']['description']
    And assert response.article['body'] == <article>['article']['body']
    And def getActualArticles = call read('abmarticle.feature@getAllArticles')
    And assert getActualArticles.response.articles[randomIndex]['title'] == response.article['title']
    And assert getActualArticles.response.articles[randomIndex]['body'] == response.article['body']
    And assert getActualArticles.response.articles[randomIndex]['description'] == response.article['description']

    @putANewArticle
    Examples:
      |slug                                            | article                                                          |
      |getArticles.response.articles[randomIndex].slug | read('classpath:resources/abmarticle/abmPutArticleRequest.json') |

    @putToOriginalArticle
    Examples:
      |slug                                            | article                                                          |
      |getArticles.response.articles[randomIndex].slug | read('classpath:resources/abmarticle/abmNewArticleRequest.json') |

  @getAllArticles
  Scenario: Get all the articles from articles list

    Given path 'articles'
    When method get
    Then status 200
    Then def getArticlesSchema = read('classpath:abmarticle/abmGetArticlesResponseSchema.json')
    Then match each response[*]['articles'] == getArticlesSchema
