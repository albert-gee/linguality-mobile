import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../configuration/configuration.dart';
import '../key_storage.dart';

class AuthService {

  final Configuration settings = Configuration();
  final KeyStorage keyStorage = KeyStorage();

  Future<String?> getAccessToken() async {
    return await keyStorage.read(settings.secureStorageKeyAccessToken);
  }

  Future<bool> authenticate() async {
    String? accessToken = await keyStorage.read(settings.secureStorageKeyAccessToken);
    String? refreshToken = await keyStorage.read(settings.secureStorageKeyRefreshToken);
    String? expiresAt = await keyStorage.read(settings.secureStorageKeyExpiresAt);

    // Check if token is saved in secure storage. If not, authenticate with
    // browser. Otherwise update the token
    if (accessToken == null || refreshToken == null || expiresAt == null) {
      try {
        await _authenticateWithBrowser();
      } catch (e) {
        return false;
      }
    } else {
      try {
        await _updateToken(accessToken, refreshToken, expiresAt);
      } catch (error) { // If token update fails, authenticate with browser
        try {
          await _authenticateWithBrowser();
        } catch (e) {
          return false;
        }
      }
    }

    return true;
  }

  Future<Client> _getClient() async {
    Issuer issuer = await Issuer.discover(Uri.parse(
        '${settings.oauth2ServerUrl}/realms/${settings.oauth2Realm}'));
    return Client(issuer, settings.oauth2ClientName, clientSecret: settings.oauth2ClientSecret);
  }

  Future<void> _writeTokens(TokenResponse tokenResponse) async {
    keyStorage.write(settings.secureStorageKeyAccessToken, tokenResponse.accessToken);
    keyStorage.write(settings.secureStorageKeyRefreshToken, tokenResponse.refreshToken);
    keyStorage.write(settings.secureStorageKeyExpiresAt, tokenResponse.expiresAt.toString());
  }

  Future<void> _updateToken(String accessToken, String refreshToken, String expiresAt) async {
    final client = await _getClient();
    Credential credential = client.createCredential(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: settings.secureStorageKeyTokenType,
      expiresAt: DateTime.parse(expiresAt ?? ''),
    );

    TokenResponse tokenResponse = await credential.getTokenResponse(true);
    await _writeTokens(tokenResponse);

  }

  Future<void> _authenticateWithBrowser() async {
    final client = await _getClient();

    // open the authentication endpoint in web browser
    urlLauncher(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

    // create an authenticator
    var authenticator = Authenticator(client,
        scopes: settings.oauth2ClientScopes, urlLancher: urlLauncher);

    // starts the authentication
    var credential = await authenticator.authorize();

    // close the web-view when finished
    closeInAppWebView();

    // store the token in secure storage
    TokenResponse tokenResponse = await credential.getTokenResponse(true);
    await _writeTokens(tokenResponse);
  }
}