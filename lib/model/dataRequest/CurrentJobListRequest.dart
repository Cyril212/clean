import 'dart:convert';

import 'package:clean/model/jobList/CurrentJobList.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'JobListRequest.dart';

class CurrentJobListRequest extends JobListRequest {

  /// GetHttpRecordsDataRequest initialization
  CurrentJobListRequest({required int userId})
      : super(
          userId: userId,
          mockUpRequestOptions: MockUpRequestOptions(
            delayedResult: true,
            assetDataPath: "assets/mockUpData/jobLists/MockCurrentJobListResponse.json",
          ),
          method: CurrentJobList.METHOD,
          processResult: (json) {
            final String recordsJson = json['response'] ?? '[]';

            return CurrentJobList.fromJson(<String, dynamic>{
              'list': jsonDecode(recordsJson),
            });
          },
        );
}

