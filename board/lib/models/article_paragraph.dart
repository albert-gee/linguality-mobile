class ArticleParagraph {
  final int id;
  final String text;

  ArticleParagraph({required this.id, required this.text});

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
  };

  ArticleParagraph.fromJson(Map<String, dynamic> json) : id = json['id'], text = json['text'];
}