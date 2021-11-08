
import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'Job.dart';

class SignContract extends DataModel {
  late int status;
  late JobStatus jobStatus;
  late String? errorMessage;

  SignContract.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    status = json['status']; //TODO my guess there should be some enum
    jobStatus = JobStatus.values.elementAt(json['jobStatus']);
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['status'] = status;
    json['jobStatus'] = jobStatus.index;
    json['errorMessage'] = errorMessage;
    return json;
  }
}
