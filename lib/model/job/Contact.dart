import 'package:tch_appliable_core/tch_appliable_core.dart';

class Contact extends DataModel {
  late String name;
  late String label;
  late String phone;

  Contact.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json['name'];
    label = json['label'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['label'] = this.label;
    data['phone'] = this.phone;
    return data;
  }

  String formattedPhoneNumber() => phone.replaceAll(" ","");
}