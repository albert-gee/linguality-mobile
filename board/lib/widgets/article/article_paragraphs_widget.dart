import 'package:board/models/article_paragraph.dart';
import 'package:flutter/material.dart';

/// Article paragraphs are shown below the article image.
class ArticleParagraphsWidget extends StatelessWidget {
  final List<ArticleParagraph> articleParagraphs;

  const ArticleParagraphsWidget({Key? key, required this.articleParagraphs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 130),
        child: Column(
          children: articleParagraphs.map((paragraph) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                paragraph.text,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ));
  }
}