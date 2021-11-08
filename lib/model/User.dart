import 'package:tch_appliable_core/tch_appliable_core.dart';

class User extends DataModel{
  late int userId;

  User.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['userId'] = userId;
    return json;
  }
}