import 'package:clean/model/request/ForgotPasswordRequest.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../DefaultResult.dart';

class ForgotPasswordDataTask extends DataTask<ForgotPasswordRequest, DefaultResult> {
  ForgotPasswordDataTask({
    required ForgotPasswordRequest data,
  }) : super(
    method: ForgotPasswordRequest.STORE,
    options: HTTPTaskOptions(
      type: HTTPType.Get,
    ),

    mockUpTaskOptions: MockUpTaskOptions(
        type: MockUpType.Query,
        assetDataPath: "assets/mockUpData/forgotPassword/MockForgotPasswordResponse.json"
    ),
    data: data,
    processResult: (Map<String, dynamic> json) => DefaultResult.fromJson(json),
    reFetchMethods: [ForgotPasswordRequest.STORE],
  );
}