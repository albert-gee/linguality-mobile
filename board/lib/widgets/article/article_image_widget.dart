import 'package:flutter/material.dart';

/// Article image is shown below the buttons container.
class ArticleImageWidget extends StatelessWidget {
  final String imageUrl;

  const ArticleImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Image.network(imageUrl),
    );
  }
}