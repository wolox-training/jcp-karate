Feature: Testing the react herokuapp for Sign up users

  Background:
    * url baseUrl

  @postNewUser
  Scenario: Sign up a new user in the app

    * def func = karate.call('classpath:src/test/RandomStringGenerator.js', [6])
    * def randomEmail = func + '@gmail.com'
    * def randomPassword = func
    * def randomUsername = func

    * def user =
      """
      {
        "user": {
           "email": '#(randomEmail)',
           "password":'#(randomPassword)',
           "username": '#(randomUsername)'
        }
      }
      """

    Given path 'users'
    And request user
    When method post
    Then status 200
    And match response.user['email'] == user['user']['email']
    And match response.user['username'] == user['user']['username']

  @postInvalidEmailNewUser
  Scenario Outline: sign up a user with invalid email

    * def user =
      """
      {
        "user": {
           "email": "ejemplo2gmail.com",
           "password":"ejemplo123",
           "username":"ejemploejemplo"}
           }
      """

    Given path 'users'
    And request user
    When method post
    Then status 422

    And match response == <errors>

    Examples:
      |errors|
      |{"errors":{"email":["is invalid"]}}|

  @postInvalidPasswordNewUser
  Scenario Outline: sign up a user with invalid/short password

    * def user =
      """
      {
        "user": {
           "email": "ejemplo44@gmail.com",
           "password":"eje",
           "username":"ejemplo44"}
           }
      """

    Given path 'users'
    And request user
    When method post
    Then status 422

    And match response == <errors>

    Examples:
      |errors|
      |{"errors":{"password":["is too short (minimum is 6 characters)"]}}|

  @postEmptyFieldsNewUser
  Scenario Outline: sign up a user with empty fields

    * def user =
      """
      {
        "user": {
           "email": "",
           "password":"",
           "username":""}
           }
      """

    Given path 'users'
    And request user
    When method post
    Then status 422

    And match response == <errors>

    Examples:
      |errors|
      |{"errors":{"email":["can't be blank"],"password":["can't be blank"],"username":["is invalid","can't be blank"]}}|


