import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/board_bloc/board_bloc.dart';

/// This describes an individual article card in Latest Articles widget.
class LatestArticlesCardWidget extends StatelessWidget {
  final String imageUrl;
  final String articleId;
  final String articleTitle;
  final BoardBloc boardBloc;

  const LatestArticlesCardWidget(
      {Key? key, required this.imageUrl, required this.articleId, required this.articleTitle, required this.boardBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            _buildArticleCardImage(context, imageUrl, articleId),
            _buildArticleCardTitle(articleTitle),
          ],
        ));
  }

  Widget _buildArticleCardImage(BuildContext context, String imageUrl, String articleId) {
    return GestureDetector(
        onTap: () {
          _tapArticle(articleId, context);
        },
        child: SizedBox(
          width: 280,
          height: 200,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ));
  }

  Widget _buildArticleCardTitle(String articleTitle) {
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

  void _tapArticle(String articleId, BuildContext context) {
    BlocProvider.of<BoardBloc>(context)
        .add(OpenArticleEvent(articleId));
    // boardBloc.add(OpenArticleEvent(articleId));
  }
}
