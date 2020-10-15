Feature: Testing the react herokuapp for Sign up users

  Background:
    * url baseUrl

  Scenario: Sign up a new user in the app

    * def randomString =
    """
    function(nbCharacters) {
       var text = '';
       var possible = 'abcdefghijklmnñopqrstuvwxyz0123456789';
       for(var i = 0; i < nbCharacters; i++) {
         text += possible.charAt(Math.floor(Math.random() * possible.length));
       }
       return text
    }
    """

    * def randomEmail = randomString(6) + '@gmail.com'

    * def user =
      """
      {
        "user": {
           "email": '#(randomEmail)',
           "password":"ejemplo123",
           "username": '#(randomString(6))'
        }
      }
      """

    Given path 'users'
    And request user
    When method post
    Then status 200

    * print ('random email random email random email random email:', randomEmail)

  Scenario: sign up a user with invalid email

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

    * def jsonResponse = {"errors":{"email":["is invalid"]}}
    * match response == jsonResponse


  Scenario: sign up a user with invalid/short password

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

    * def jsonResponse = {"errors":{"password":["is too short (minimum is 6 characters)"]}}
    * match response == jsonResponse


  Scenario: sign up a user with empty fields

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

    * def jsonResponse = {"errors":{"email":["can't be blank"],"password":["can't be blank"],"username":["is invalid","can't be blank"]}}
    * match response == jsonResponse

