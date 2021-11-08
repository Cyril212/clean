import 'package:clean/model/request/LoginRequest.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../User.dart';

class LoginDataTask extends DataTask<LoginRequest, User> {
  /// LoginMockupDataTask initialization
  LoginDataTask({
    required LoginRequest data,
  }) : super(
    method: LoginRequest.STORE,
    options: HTTPTaskOptions(
      type: HTTPType.Get,
    ),
    mockUpTaskOptions: MockUpTaskOptions(
        type: MockUpType.Query,
        assetDataPath: "assets/mockUpData/authorization/MockLoginResponse.json"
    ),
    data: data,
    processResult: (Map<String, dynamic> json) => User.fromJson(json),
    reFetchMethods: [LoginRequest.STORE],
  );
}
