class PossibleAnswer {
  String id;
  String text;

  PossibleAnswer({required this.id, required this.text});

  PossibleAnswer.fromJson(Map<String, dynamic> json):
        id = json['id'],
        text = json['text'];
}