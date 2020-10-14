function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env){
    env = 'qa';
    }

  var jsonConfig = read('classpath:src/test/resources/environments.json');

  var config = {
        env: env,
        baseUrl: jsonConfig[env].baseUrl
    }
  return config;

}
