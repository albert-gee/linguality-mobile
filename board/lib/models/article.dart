import 'package:board/models/article_paragraph.dart';

class Article {
  final int id;
  final String title;
  final String imageUrl;
  final List<ArticleParagraph> paragraphs;

  Article({required this.id, required this.title, required this.imageUrl, required this.paragraphs});

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'imageUrl': imageUrl,
    'paragraphs': paragraphs,
  };

  Article.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['imageUrl'],
        paragraphs = List<ArticleParagraph>.from(
            json['paragraphs'].map(
                    (x) => ArticleParagraph.fromJson(x)
            ));
}