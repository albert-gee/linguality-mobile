import 'package:board/bloc/board_bloc/board_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/article.dart';

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
        return _buildArticleCard(context, article.imageUrl, article.id.toString(), article.title);
      }).toList(),
    );
  }

  /// This method builds an individual article card.
  Widget _buildArticleCard(BuildContext context, String imageUrl, String articleId, String articleTitle) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: 300,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            _buildArticleCardImage(imageUrl, articleId),
            _buildArticleCardTitle(context, articleTitle),
          ],
        ));
  }

  Widget _buildArticleCardImage(String imageUrl, String articleId) {
    return GestureDetector(
        onTap: () {
          _tapArticle(articleId);
        },
        child: SizedBox(
          width: 280,
          height: 200,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ));
  }

  Widget _buildArticleCardTitle(BuildContext context, String articleTitle) {
    return Container(
      height: 32,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          articleTitle,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _tapArticle(String articleId) {
    boardBloc.add(OpenArticleEvent(articleId));
  }
}
