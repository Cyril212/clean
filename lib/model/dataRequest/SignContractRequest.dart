import 'package:tch_appliable_core/tch_appliable_core.dart';

class SignContractRequest extends DataModel {
  static const String STORE = 'sign_contract';

  int userId;
  int jobId;

  /// Initialization
  SignContractRequest({required this.userId, required this.jobId}) : super.fromJson(Map());

  /// Covert the object into JSON map
  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'jobId': jobId,
    };
  }
}