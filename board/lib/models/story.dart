class Story {
  final int id;
  final String title;
  final String imageUrl;

  Story({required this.id, required this.title, required this.imageUrl});

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'imageUrl': imageUrl,
  };

  Story.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['imageUrl'];
}
