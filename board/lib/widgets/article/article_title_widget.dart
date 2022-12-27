import 'package:flutter/material.dart';

/// Title of the article is shown at the top of the screen.
class ArticleTitleWidget extends StatelessWidget {
  final String title;

  const ArticleTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}