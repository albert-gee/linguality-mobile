import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'liguality_app.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Credential credential = await _authenticate(
      Uri.parse('http://192.168.50.30:28080/realms/Linguality'),
      'mobile',
      ['openid', 'profile', 'email']
  );
  var token = await credential.getTokenResponse();
  var userAccessToken = token.accessToken;

  var storage = const FlutterSecureStorage();
  await storage.write(
    key: 'jwt',
    value: userAccessToken,
    iOptions: const IOSOptions(),
    aOptions: const AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    ),
  );

  // await c.client.httpClient?.post(
  //     Uri.parse('http://10.65.3.116:18888/bot/respond'),
  //     body: Message(text: 'Hello', messageType: MessageType.user, timestamp: DateTime.now())
  // ).then((value) => print('dfgdfgh'));
  // return User(
  //     name: userInformation['given_name'],
  //     email: userInformation['email'],
  //     emailVerified: userInformation['email_verified'],
  //     id: userInformation['sub']
  // );


  // var user = User(
  //     id: '1',
  //     name: 'John Doe',
  //     email: 'user@user.ru', emailVerified: true
  // );
  var userInformation = await credential.getUserInfo();
  var user = User(
      name: userInformation['given_name'],
      email: userInformation['email'],
      emailVerified: userInformation['email_verified'],
      id: userInformation['sub']
  );
  runApp(LingualityApp(user: user));
}

Future<Credential> _authenticate(Uri uri, String clientId, List<String> scopes) async {

  // create the client
  var issuer = await Issuer.discover(uri);
  var client = Client(issuer, clientId, clientSecret: 'lAD6Bd7f9vHlaqSBvfvtB0WXiMt0TJVb');

  // create a function to open a browser with an url
  urlLauncher(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // create an authenticator
  var authenticator = Authenticator(
      client,
      scopes: scopes,
      port: 28080,
      urlLancher: urlLauncher);

  // starts the authentication
  var credential = await authenticator.authorize();

  // close the webview when finished
  closeInAppWebView();

  return credential;
}

