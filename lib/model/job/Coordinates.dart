import 'package:tch_appliable_core/tch_appliable_core.dart';

class Coordinates extends DataModel {
  late double lat;
  late double long;

  Coordinates.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}