Feature: Testing the react herokuapp for Sign in users

  Background:
    * url baseUrl

  Scenario: Sign in user in the app

    * def user =
      """
      {
        "user": {
           "email": 'hrctri@gmail.com',
           "password":"ejemplo123",
           "username": 'pdw4l7'
        }
      }
      """

    Given path 'users/login'
    And request user
    When method post
    Then status 200


  Scenario: sign in a user with invalid email

    * def user =
      """
      {
        "user": {
           "email": "hrctrigmail.com",
           "password":"ejemplo123",
           "username":"pdw4l7"}
           }
      """

    Given path 'users/login'
    And request user
    When method post
    Then status 422

    * def jsonResponse = {"errors":{"email or password":["is invalid"]}}
    * match response == jsonResponse


  Scenario: sign in a user with invalid password

    * def user =
      """
      {
        "user": {
           "email": "hrctri@gmail.com",
           "password":"ejemplo1",
           "username":"pdw4l7"
        }
      }
      """

    Given path 'users/login'
    And request user
    When method post
    Then status 422

    * def jsonResponse = {"errors":{"email or password":["is invalid"]}}
    * match response == jsonResponse


  Scenario: sign in a user with empty fields

    * def user =
      """
      {
        "user": {
           "email": "",
           "password":"",
           "username":""}
           }
      """

    Given path 'users/login'
    And request user
    When method post
    Then status 422

    * def jsonResponse = {"errors":{"email or password":["is invalid"]}}
    * match response == jsonResponse

