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
        height: 262,
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
    return GestureDetector(
      onTap: () {
        print('GESTURE');
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
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