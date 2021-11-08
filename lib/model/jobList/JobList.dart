import 'package:clean/model/job/Job.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

abstract class JobListModel extends DataModel {
  late List<Job> jobList;

  JobListModel.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}