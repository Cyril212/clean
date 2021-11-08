import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'Address.dart';

enum PlaceType { house, apartment, office }

const PlaceTypeMap = <PlaceType, dynamic>{
  PlaceType.house: 'House',
  PlaceType.apartment: 'Apartment',
  PlaceType.office: 'Office',
};

class Place extends DataModel {
  late int id;
  late PlaceType placeType;
  late Address address;

  Place.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'];
    placeType = PlaceType.values.elementAt(json['placeType']);
    address = json['address'] != null ?  Address.fromJson(json['address']) : Address.fromJson(<String, dynamic>{});
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['id'] = id;
    json['placeType'] = placeType.index;
    json['address'] = address.toJson();
    return json;
  }
}