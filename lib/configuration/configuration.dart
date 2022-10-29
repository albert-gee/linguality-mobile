class Configuration {
  late final String oauth2ServerUrl;
  late final String oauth2Realm;
  late final String oauth2ClientName;
  late final String oauth2ClientSecret;
  late final List<String> oauth2ClientScopes;
  late final String apiServerUrl;
  late final String secureStorageKeyJwt;

  Configuration() {
    // Dev environment
    oauth2ServerUrl = 'http://192.168.50.30:28080';
    oauth2Realm = 'Linguality';
    oauth2ClientName = 'mobile';
    oauth2ClientSecret = 'lAD6Bd7f9vHlaqSBvfvtB0WXiMt0TJVb';
    oauth2ClientScopes = ['openid', 'profile', 'email'];
    apiServerUrl = 'http://192.168.50.30:18888';
    secureStorageKeyJwt = 'jwt';

    //Prod environment
  }
}
