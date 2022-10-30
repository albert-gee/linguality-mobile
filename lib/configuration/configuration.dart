class Configuration {
  final String environment = 'dev-home'; // dev-bcit, dev-home
  late final String oauth2ServerUrl;
  late final String oauth2Realm;
  late final String oauth2ClientName;
  late final String oauth2ClientSecret;
  late final List<String> oauth2ClientScopes;
  late final String apiServerUrl;

  Configuration() {
    if (environment == 'dev-home') {
      oauth2ServerUrl = 'http://192.168.50.30:28080';
      apiServerUrl = 'http://192.168.50.30:18888';
    } else if (environment == 'dev-bcit') {
      oauth2ServerUrl = 'http://10.65.8.78:28080';
      apiServerUrl = 'http://10.65.8.78:18888';
    } else {
      throw Exception('Unknown environment: $environment');
    }

    oauth2Realm = 'Linguality';
    oauth2ClientName = 'mobile';
    oauth2ClientSecret = 'lAD6Bd7f9vHlaqSBvfvtB0WXiMt0TJVb';
    oauth2ClientScopes = ['openid', 'profile', 'email'];
  }
}
