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
    Then match response == {"user":{"id":'#number',"email":'#string',"username":'#string',"bio":null,"image":null,"token":'#string'}}
    And assert response.user['email'] == user['user']['email']
    And assert response.user['username'] == user['user']['username']

  @postInvalidNewUser
  Scenario Outline: sign up a user with invalid fields

    * def user = { "user": { "email": '#(email)',"password": '#(password)',"username":'#(username)'}}
    * def signUpErrorResponse = read('classpath:src/test/resources/signupInvalidResponse.json')

    Given path 'users'
    And request user
    When method post
    Then status 422

    And match response == <errors>

    @invalidEmail
    Examples:
      |errors                             | email                  | password    | username           |
      |signUpErrorResponse['invalidEmail']| ejemplo2345gmail.com | ejemplo123    | ejemploNewUsername |

    @invalidPassword
    Examples:
      |errors                                | email                 | password | username             |
      |signUpErrorResponse['invalidPassword']| ejemplo2345@gmail.com | eje      | ejemploejemplo1234   |

    @emptyFields
    Examples:
      |errors                             | email | password | username |
      |signUpErrorResponse['emptyFields'] |  ""   | ""       | ""       |