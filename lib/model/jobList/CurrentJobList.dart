
import 'package:clean/model/job/Job.dart';

import 'JobList.dart';

class CurrentJobList extends JobListModel {
  static const String METHOD = '/current_job_list';

  CurrentJobList.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    jobList = [];
    if (json['list'] != null) {
      final Map<String, dynamic> list = Map<String, dynamic>.from(json['list']);

      list['currentJobList'].forEach((item) {
        // look up at json
        jobList.add(Job.fromJson(item));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.jobList != null) {
      data['currentJobList'] = this.jobList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}