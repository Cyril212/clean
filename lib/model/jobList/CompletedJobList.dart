
import 'package:clean/model/job/Job.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'JobList.dart';

class CompletedJobList extends JobListModel {

  static const String METHOD = '/completed_job_list';

  CompletedJobList.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    jobList = [];
    if (json['list'] != null) {
      final Map<String, dynamic> list = Map<String, dynamic>.from(json['list']);

      list['completeJobList'].forEach((item) {
        // look up at json
        jobList.add(Job.fromJson(item));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.jobList != null) {
      data['completeJobList'] = this.jobList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}