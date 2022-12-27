import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {

  final String appTitle;
  final IconData appTitleIcon;

  const AppLogoWidget({Key? key, required this.appTitle, required this.appTitleIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          appTitleIcon,
          size: 24,
        ),
        Text(
          appTitle,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        // Text(title),
      ],
    );
  }
}