import 'package:flutter/material.dart';
import 'package:linguality_mobile/screens/home/home_page.dart';
import 'package:linguality_mobile/configuration/configuration.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils/key_storage.dart';
import 'models/user.dart';

class LingualityApp extends StatelessWidget {
  final Configuration settings = Configuration();
  final KeyStorage keyStorage = KeyStorage();

  static const String appTitle = 'Linguality';

  LingualityApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<User>(
        future: _authenticate(),
        builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return HomePage(
            title: appTitle,
            user: snapshot.data!,
          );
        } else {
          return const CircularProgressIndicator();
        }
      }),

    );
  }


  Future<User> _authenticate() async {

    // create the oAuth2 client
    var issuer = await Issuer.discover(Uri.parse('${settings.oauth2ServerUrl}/realms/${settings.oauth2Realm}'));
    var client = Client(issuer, settings.oauth2ClientName, clientSecret: settings.oauth2ClientSecret);

    // open the authentication endpoint in web browser
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
        scopes: settings.oauth2ClientScopes,
        urlLancher: urlLauncher);

    // starts the authentication
    var credential = await authenticator.authorize();

    // close the webview when finished
    closeInAppWebView();

    // store the token in secure storage
    var token = await credential.getTokenResponse();
    var userAccessToken = token.accessToken;
    keyStorage.write(settings.secureStorageKeyJwt, userAccessToken);

    var userInformation = await credential.getUserInfo();
    return User(
        name: userInformation['given_name'],
        email: userInformation['email'],
        emailVerified: userInformation['email_verified'],
        id: userInformation['sub']
    );
  }
}