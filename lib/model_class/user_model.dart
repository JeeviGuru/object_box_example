import 'package:objectbox/objectbox.dart';

@Entity()
class UserModel {
  int id;
  String title;
  String content;

  UserModel({this.id = 0, required this.title, required this.content});
  // Map<String, dynamic> toMap() {
  //   return {'id': id, 'title': title, 'content': content};
  // }
}
