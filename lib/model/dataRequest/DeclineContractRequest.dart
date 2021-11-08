import 'package:tch_appliable_core/tch_appliable_core.dart';

class DeclineContractRequest extends DataModel {
  static const String STORE = 'decline_contract';

  int userId;
  int jobId;
  String note;

  /// Initialization
  DeclineContractRequest({required this.jobId, required this.userId, required this.note}) : super.fromJson(Map());

  /// Covert the object into JSON map
  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'jobId': jobId,
      'note': note,
    };
  }
}
