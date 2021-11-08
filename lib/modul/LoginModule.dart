import 'package:clean/model/dataTask/LoginDataTask.dart';
import 'package:clean/model/request/LoginRequest.dart';
import 'package:clean/ui/screens/login/LoginScreen.dart';

import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../App.dart';

class LoginManagerModule {
  static const String TAG = 'LoginManagerModule';

  /// Authorize user by email and password
  Future<LoginDataTask> login(BuildContext context, String email, String password) {
    AppDataState.of<AppDataStateSnapshot>(context)!.securePreferencesModule.putEmail(email);
    AppDataState.of<AppDataStateSnapshot>(context)!.securePreferencesModule.putPassword(password);

    return MainDataProvider.instance!.executeDataTask(LoginDataTask(data: LoginRequest(email, password)));
  }

  /// Clear email and password, redirect to LoginScreen
  Future logout(BuildContext context) {
    return AppDataState.of<AppDataStateSnapshot>(context)!
        .securePreferencesModule
        .clearUserData()
        .then((result) => pushNamedNewStack(context, LoginScreen.ROUTE));
  }

  /// Find out whether user is able to autologin
  Future<bool> canAutologin(BuildContext context) {
    return AppDataState.of<AppDataStateSnapshot>(context)!.securePreferencesModule.getEmail().then((email) => email != null);
  }

  /// Find out whether user is able to autologin
  Future<LoginDataTask?> autologin(BuildContext context) {
    return canAutologin(context).then((canAutoLogin) {
      if (canAutoLogin) {
        return AppDataState.of<AppDataStateSnapshot>(context)!
            .securePreferencesModule
            .getEmail()
            .then((email) => AppDataState.of<AppDataStateSnapshot>(context)!.securePreferencesModule.getPassword()
            .then((password) => MainDataProvider.instance!.executeDataTask(LoginDataTask(data: LoginRequest(email!, password!)))).then((task) {
                  if (task.result != null) {
                    AppDataState.of<AppDataStateSnapshot>(context)!.securePreferencesModule.putUserId(task.result!.userId);
                  }
                  return task;
                }));
      } else {
        return Future.value(null);
      }
    });
  }
}
