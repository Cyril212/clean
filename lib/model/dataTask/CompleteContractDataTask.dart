import 'package:clean/model/dataRequest/CompleteContractRequest.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../DefaultResult.dart';

class CompleteContractDataTask extends DataTask<CompleteContractRequest, DefaultResult> {
  /// LoginMockupDataTask initialization
  CompleteContractDataTask({
    required CompleteContractRequest data,
  }) : super(
    method: CompleteContractRequest.STORE,
    options: HTTPTaskOptions(
      type: HTTPType.Get,
    ),

    mockUpTaskOptions: MockUpTaskOptions(
        type: MockUpType.Query,
        assetDataPath: "assets/mockUpData/jobDetails/MockCompleteContractResponse.json",
    ),
    data: data,
    processResult: (Map<String, dynamic> json) => DefaultResult.fromJson(json),
    reFetchMethods: [CompleteContractRequest.STORE],
  );
}