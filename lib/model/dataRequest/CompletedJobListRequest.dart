import 'dart:convert';

import 'package:clean/model/jobList/CompletedJobList.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'JobListRequest.dart';

class CompletedJobListRequest extends JobListRequest {

  /// GetHttpRecordsDataRequest initialization
  CompletedJobListRequest({required int userId})
      : super(
          userId: userId,
          mockUpRequestOptions: MockUpRequestOptions(
            delayedResult: true,
            assetDataPath: "assets/mockUpData/jobLists/MockCompleteJobListResponse.json",
          ),
          method: CompletedJobList.METHOD,
          processResult: (json) {
            final String recordsJson = json['response'] ?? '[]';

            return CompletedJobList.fromJson(<String, dynamic>{
              'list': jsonDecode(recordsJson),
            });
          },
        );
}
