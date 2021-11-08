import 'package:clean/model/job/Job.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'JobList.dart';

class AvailableJobList extends JobListModel {

  static const String METHOD = '/available_job_list';

  AvailableJobList.fromJson(Map<String, dynamic> json) : super.fromJson(json){
      jobList = [];
      if (json['list'] != null) {
        final Map<String, dynamic> list = Map<String, dynamic>.from(json['list']);

        list['availableJobList'].forEach((item) {
          // look up at json
          jobList.add(Job.fromJson(item));
        });
      }
  }

  @override
  Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();

      if (this.jobList != null) {
        data['availableJobList'] = this.jobList.map((v) => v.toJson()).toList();
      }
      return data;
  }

}
