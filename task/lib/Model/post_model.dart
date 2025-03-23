import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class PostModel {
  @HiveField(0) // userId
  int? userId;

  @HiveField(1) // id
  int? id;

  @HiveField(2) //title
  String? title;

  @HiveField(3) // body
  String? body;

  PostModel({this.userId, this.id, this.title, this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
