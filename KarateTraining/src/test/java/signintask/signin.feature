Feature: Testing the react herokuapp for Sign in users

  Background:
    * url baseUrl

  @postSignInUser
  Scenario: Sign in user in the app

    * def user = user

    Given path 'users', 'login'
    And request user
    When method post
    Then status 200
    Then match response == read('classpath:signInSignUpResponse.json')
    And assert response.user['email'] == user['user']['email']
    And assert response.user['username'] == user['user']['username']


  @postSignInInvalidUser
  Scenario Outline: sign in a user with invalid email

    * def signInErrorResponse = read('classpath:signinInvalidResponse.json')
    * def signInInvalidSchema = read('classpath:signInInvalidResponseSchema.json')
    * def user = { "user": { "email": '#(email)', "password": '#(password)', "username": '#(username)'}}


    Given path 'users', 'login'
    And request user
    When method post
    Then status 422
    Then match response['errors'] == signInInvalidSchema['errors']
    And match response == <errors>

    @invalidEmail
    Examples:
      |errors                                 | email                   | password   | username           |
      |signInErrorResponse['invalidResponse'] | ejemplo123890@gmail.com | ejemplo123 | ejemploNewUsername |

    @invalidPassword
    Examples:
      |errors                                 | email            | password | username |
      |signInErrorResponse['invalidResponse'] | hrctri@gmail.com | ejemplo1 | pdw4l7   |

    @emptyFields
    Examples:
      |errors                                | email | password | username |
      |signInErrorResponse['invalidResponse']| ""    | ""       | ""       |
