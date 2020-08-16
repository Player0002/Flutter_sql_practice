class ToDoModel {
  final int id; // Primary key
  final DateTime whens;
  final String title;
  final String contents;

  ToDoModel({this.id, this.whens, this.title, this.contents});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "id": id,
      "whens": whens.millisecondsSinceEpoch,
      "title": title,
      "contents": contents
    };
    if (id != null) data['id'] = id;

    return data;
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) => ToDoModel(
        id: map["id"],
        whens: DateTime.fromMillisecondsSinceEpoch(map["whens"]),
        title: map["title"],
        contents: map["contents"],
      );
}
