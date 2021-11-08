import 'dart:convert';

import 'package:clean/model/jobList/AvailableJobList.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'JobListRequest.dart';

class AvailableJobListRequest extends JobListRequest {

  /// GetHttpRecordsDataRequest initialization
  AvailableJobListRequest({required int userId})
      : super(
          userId: userId,
          mockUpRequestOptions: MockUpRequestOptions(
            delayedResult: true,
            assetDataPath: "assets/mockUpData/jobLists/MockAvailableJobListResponse.json",
          ),
          method: AvailableJobList.METHOD,
          processResult: (json) {
            final String recordsJson = json['response'] ?? '[]';

            return AvailableJobList.fromJson(<String, dynamic>{
              'list': jsonDecode(recordsJson),
            });
          },
        );
}
