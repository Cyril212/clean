import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'Coordinates.dart';

class Address extends DataModel {
  late int id;
  late String fullAddress;
  late Coordinates? coordinates;

  Address.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'];
    fullAddress = json['fullAddress'];
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullAddress'] = this.fullAddress;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    return data;
  }
}