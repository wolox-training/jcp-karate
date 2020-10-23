
Feature: Testing the react herokuapp for creation , modification and removal

  Background:
    * url baseUrl
    * def abmArticlesResponseSchema = read('classpath:abmarticle/abmArticlesResponseSchema.json')
    * def getArticlesSchema = {articlesCount: '#number',articles: '#[] abmArticlesResponseSchema'}

  @getAllArticles
  Scenario: Get all the articles from articles list

    Given path 'articles'
    When method get
    Then status 200
    And match each response[*]['articles'] == getArticlesSchema
    And match response == getArticlesSchema


  @getArticleBySlug
  Scenario: Get article by slug

    Given path 'articles', slug
    When method get
    Then status 200
    And match response['article'] == abmArticlesResponseSchema
