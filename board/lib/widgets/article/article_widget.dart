import 'package:board/widgets/article/article_paragraphs_widget.dart';
import 'package:flutter/material.dart';

import '../../models/article.dart';
import 'article_image_widget.dart';
import 'article_title_widget.dart';

/// This class describes the UI of the article screen.
class ArticleWidget extends StatelessWidget {
  const ArticleWidget(
      {super.key,
      required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: Column(
        children: <Widget>[
          // ArticleTopButtonsWidget(
          //   article: article,
          //   articleListenBloc: ArticleListenBloc(
          //       articleParagraphToSpeechService:
          //           articleParagraphToSpeechService,
          //       article: article),
          // ),
          ArticleTitleWidget(title: article.title),
          ArticleImageWidget(imageUrl: article.imageUrl),
          ArticleParagraphsWidget(articleParagraphs: article.paragraphs),
        ],
      ),
    );
  }
}
