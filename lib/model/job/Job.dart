import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'Contact.dart';
import 'Place.dart';

enum JobStatus { available, confirmed, inProgress, completed }
enum JobType { general, common }

const JobStatusMap = <JobStatus, dynamic>{
  JobStatus.available: 'Available',
  JobStatus.confirmed: 'Confirmed',
  JobStatus.inProgress: 'In progress',
  JobStatus.completed: 'Completed',
};

const JobTypeMap = <JobType, dynamic>{
  JobType.general: 'Generální',
  JobType.common: 'Běžný',
};

class Job extends DataModel {
  late int? id;
  late String serviceName;
  late JobStatus jobStatus;
  late JobType jobType;
  late String description;
  late Place? place;
  late String note;
  late DateTime startDate;
  late DateTime endDate;
  late DateTime createDate;
  late List<Contact> contacts;

  // {
  // "id": "1df",
  // "serviceName": "Infinite Vile Heights",
  // "jobStatus": 1,
  // "description": "While the entire set is equipped (with the Holy Band and either the Vile Blade)",
  // "place": "",
  // "note": "",
  // "startDate": "2020-06-07 10:00",
  // "endDate": "2020-06-07 12:00",
  // "createDate": "2020-06-07 08:00"
  // }

  Job.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    contacts = [];
    id = json['id'];
    serviceName = json['serviceName'];
    jobStatus = JobStatus.values.elementAt(json['jobStatus']);
    jobType = json['jobType'] != null ? JobType.values.elementAt(json['jobType']) : JobType.values.elementAt(1);
    description = json['description'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    note = json['note'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
    createDate = DateTime.parse(json['createDate']);

    if (json['contacts'] != null) {
      final List<dynamic> list = List<dynamic>.from(json['contacts']);
      list.forEach((item) {
        contacts.add(Contact.fromJson(item));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['id'] = id;
    json['serviceName'] = serviceName;
    json['jobStatus'] = jobStatus.index;
    json['jobType'] = jobType.index;
    json['description'] = description;
    json['place'] = place != null ? place!.toJson() : null;
    json['note'] = note;
    json['startDate'] = startDate.toIso8601String();
    json['endDate'] = endDate.toIso8601String();
    json['createDate'] = createDate.toIso8601String();

    if (contacts != null) {
      json['contacts'] = contacts.map((v) => v.toJson()).toList();
    }

    return json;
  }
}
