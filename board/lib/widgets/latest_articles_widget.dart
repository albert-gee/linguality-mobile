import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/article.dart';

class LatestArticlesWidget  extends StatelessWidget {
  const LatestArticlesWidget({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 252,
      ),
      items: articles.map((article) {
        return _buildArticle(context, article.imageUrl, article.title);
      }).toList(),

    );
  }

  Widget _buildArticle(BuildContext context, String imageUrl, String articleTitle) {
    return Column(
      children: <Widget>[
        _buildArticleCard(context, imageUrl),
        _buildArticleTitle(context, articleTitle),
      ],
    );
  }

  Widget _buildArticleCard(BuildContext context, String imageUrl) {
    return SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        )
    );
  }

  Widget _buildArticleTitle(BuildContext context, String articleTitle) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          articleTitle,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}