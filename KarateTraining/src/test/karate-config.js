function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env){
    env = 'qa';
    }

  var jsonConfig = read('classpath:src/test/resources/environments.json');
  var result = karate.callSingle('classpath:src/test/java/signintask/signin.feature@postSignInUser',{'baseUrl': jsonConfig[env].baseUrl, 'user': jsonConfig[env].user});
  jsonConfig[env].authInfo = { accessToken: 'Bearer ' + result.response.user.token };

  return jsonConfig[env];
}
