import 'package:clean/model/dataRequest/SignContractRequest.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../DefaultResult.dart';

class SignContractDataTask extends DataTask<SignContractRequest, DefaultResult> {
  /// LoginMockupDataTask initialization
  SignContractDataTask({
    required SignContractRequest data,
  }) : super(
          method: SignContractRequest.STORE,
          options: HTTPTaskOptions(
            type: HTTPType.Get,
          ),
          mockUpTaskOptions: MockUpTaskOptions(
            type: MockUpType.Query,
            assetDataPath: "assets/mockUpData/jobDetails/MockSignContractResponse.json",
          ),
          data: data,
          processResult: (Map<String, dynamic> json) => DefaultResult.fromJson(json),
          reFetchMethods: [SignContractRequest.STORE],
        );
}
