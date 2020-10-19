Feature: Testing the react herokuapp for Sign up users

  Background:
    * url baseUrl

  @postNewUser
  Scenario: Sign up a new user in the app

    * def func = karate.call('classpath:src/test/RandomStringGenerator.js', [6])
    * def randomEmail = func + '@gmail.com'
    * def randomPassword = karate.call('classpath:src/test/RandomStringGenerator.js', [6])
    * def randomUsername = karate.call('classpath:src/test/RandomStringGenerator.js', [6])

    * def user = { "user": { "email": '#(randomEmail)', "password":'#(randomPassword)', "username": '#(randomUsername)'}}


    Given path 'users'
    And request user
    When method post
    Then status 200
    Then match response == read('classpath:signInSignUpResponse.json')
    And assert response.user['email'] == user['user']['email']
    And assert response.user['username'] == user['user']['username']
    * def signIn = call read('classpath:src/test/java/signintask/signin.feature@postSignInUser')

  @postInvalidNewUser
  Scenario Outline: sign up a user with invalid fields

    * def user = { "user": { "email": '#(email)',"password": '#(password)',"username":'#(username)'}}
    * def signUpErrorResponse = read('signupInvalidResponse.json')
    * def signUpInvalidSchema = read('classpath:signUpInvalidResponseSchema.json')

    Given path 'users'
    And request user
    When method post
    Then status 422
    Then match response == signUpInvalidSchema

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