import 'package:flutter/material.dart';

import '../models/article.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          color: Colors.blueGrey[50],
          child: Column(
            children: <Widget>[
              _buildArticleTitle(),
              _buildButtonsContainer(),
              _buildArticleImage(),
              _buildArticleParagraphs(),
            ],
          ),
        )
    );
  }

  _buildArticleTitle() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      child: Text(
        article.title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  _buildButtonsContainer() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
              '7 min read',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.orange,
              )
          ),
          Row(
            children: const <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                      Icons.play_circle,
                      color: Colors.orange)
              ),
              Text(
                  'Listen',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildArticleImage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Image.network(article.imageUrl),
    );
  }

  Widget _buildArticleParagraphs() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 130),
        child: Column(
          children: article.paragraphs.map((paragraph) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
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
        )
    );
  }
}
