class PostDataSendModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostDataSendModel({this.userId, this.id, this.title, this.body});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    data['userId'] = userId;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
