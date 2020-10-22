
Feature: Testing the react herokuapp for creation , modification and removal

  Background:
    * url baseUrl

  @getAllArticles
  Scenario: Get all the articles from articles list

    Given path 'articles'
    When method get
    Then status 200
    Then def getArticlesSchema = read('classpath:abmarticle/abmGetArticlesResponseSchema.json')
    And match each response[*]['articles'] == getArticlesSchema



  @getArticleBySlug
  Scenario: Get article by slug

    * def slug = ''

    Given path 'articles', slug
    When method get
    Then status 200
    Then def getArticlesSchema = read('classpath:abmarticle/abmGetArticlesResponseSchema.json')
    And match each response[*]['article'] == getArticlesSchema
