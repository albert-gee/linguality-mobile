import 'package:flutter/material.dart';
import 'package:linguality_mobile/screens/home/home_page.dart';
// import the io version
import 'package:openid_client/openid_client_io.dart';
// use url launcher package
import 'package:url_launcher/url_launcher.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  static const String appTitle = 'Linguality';

  User user = User(name: 'John Doe', email: 'test@test', emailVerified: true, id: '1234');

  _authenticate(Uri uri, String clientId, List<String> scopes) async {

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
    var authenticator = Authenticator(client,
        scopes: scopes,
        port: 28080, urlLancher: urlLauncher);

    // starts the authentication
    var c = await authenticator.authorize();

    // close the webview when finished
    closeInAppWebView();

    var userInfo = await c.getUserInfo();
    _setUser(
        User(name: userInfo['given_name'], email: userInfo['email'], emailVerified: userInfo['email_verified'], id: userInfo['sub'])
    );

    return c;

  }

  _setUser(User user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {

    var auth = _authenticate(Uri.parse("http://192.168.50.157:28080/realms/Linguality"), "mobile", []);
    // auth.then((value) => value.client.httpClient?.post(Uri.parse('http://localhost:18888/assistant/respond'), body: Message(message: 'Hello', messageType: MessageType.sender))
    //     .then((value) => print('dfgdfgh')));

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: appTitle, user: user),
    );
  }
}