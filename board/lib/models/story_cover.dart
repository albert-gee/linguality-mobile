class StoryCover {
  final int id;
  final String title;
  final String imageUrl;

  StoryCover({required this.id, required this.title, required this.imageUrl});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
      };

  StoryCover.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['imageUrl'];
}
