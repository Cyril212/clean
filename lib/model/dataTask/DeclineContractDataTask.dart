import 'package:clean/model/dataRequest/DeclineContractRequest.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../DefaultResult.dart';

class DeclineContractDataTask extends DataTask<DeclineContractRequest, DefaultResult> {
  /// LoginMockupDataTask initialization
  DeclineContractDataTask({
    required DeclineContractRequest data,
  }) : super(
    method: DeclineContractRequest.STORE,
    options: HTTPTaskOptions(
      type: HTTPType.Get,
    ),

    mockUpTaskOptions: MockUpTaskOptions(
        type: MockUpType.Query,
        assetDataPath: "assets/mockUpData/jobDetails/MockDeclineContractResponse.json"
    ),
    data: data,
    processResult: (Map<String, dynamic> json) => DefaultResult.fromJson(json),
    reFetchMethods: [DeclineContractRequest.STORE],
  );
}