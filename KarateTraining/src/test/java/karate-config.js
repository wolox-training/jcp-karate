function fn() {
  var env = karate.env; // get system property 'karate.env'
  var jsonConfig = read('classpath:src/main/resources/qa.json');
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'qa';
    var config = {
        env: env,
        baseUrl: jsonConfig.baseQaUrl
      }
  }

  if (env == 'dev') {
  var config = {
          env: env,
          baseUrl: jsonConfig.baseDevUrl
        }
      } else if (env == 'stg') {
      var config = {
              env: env,
              baseUrl: jsonConfig.baseStgUrl
            }
      }

  return config;
}