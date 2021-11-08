import 'package:tch_appliable_core/tch_appliable_core.dart';

class ForgotPasswordRequest extends DataModel {
  static const String STORE = 'forgot_password';

  String email;

  /// Initialization
  ForgotPasswordRequest(this.email) : super.fromJson(Map());

  /// Covert the object into JSON map
  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
    };
  }
}