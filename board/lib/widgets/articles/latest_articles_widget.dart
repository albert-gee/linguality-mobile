import 'package:board/bloc/board_bloc/board_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/article.dart';
import 'latest_articles_card_widget.dart';

/// This class describes the latest articles widget UI.
class LatestArticlesWidget extends StatelessWidget {
  const LatestArticlesWidget({super.key, required this.articles, required this.boardBloc});

  final List<Article> articles;
  final BoardBloc boardBloc;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 292,
      ),
      items: articles.map((article) {
        return LatestArticlesCardWidget(
          imageUrl: article.imageUrl,
          articleId: article.id.toString(),
          articleTitle: article.title,
          boardBloc: boardBloc,
        );
      }).toList(),
    );
  }
}
