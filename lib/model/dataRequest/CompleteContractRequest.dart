import 'package:tch_appliable_core/tch_appliable_core.dart';

class CompleteContractRequest extends DataModel {
  static const String STORE = 'complete_contract';

  int jobId;
  int userId;

  /// Initialization
  CompleteContractRequest({required this.jobId, required this.userId}) : super.fromJson(Map());

  /// Covert the object into JSON map
  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'jobId': jobId,
      'userId': userId,
    };
  }
}
