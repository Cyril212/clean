import 'dart:convert';

import 'package:clean/model/jobList/JobList.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

abstract class JobListRequest extends DataRequest<JobListModel> {
  JobListRequest(
      {int? userId,
      MainDataProviderSource? sourceRegisteredTo,
      MockUpRequestOptions? mockUpRequestOptions,
      required String method,
      required JobListModel? Function(Map<String, dynamic> json) processResult})
      : super(source: MainDataProviderSource.HTTPClient, method: method, mockUpRequestOptions: mockUpRequestOptions, parameters: <String, dynamic>{'userId': userId}, processResult: processResult);
}
