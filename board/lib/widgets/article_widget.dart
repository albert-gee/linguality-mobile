import 'package:board/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';

import '../models/article.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionTitleWidget(title: article.title),
        Container(
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
              image: NetworkImage(article.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}