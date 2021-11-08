import 'package:clean/ui/screens/login/LoginScreen.dart';
import 'package:flutter/services.dart';
import 'package:clean/core/AppRouter.dart' as AppRouter;

import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'core/AppTheme.dart';
import 'modul/LoginModule.dart';
import 'modul/SecurePreferencesModule.dart';

class App extends AbstractStatefulWidget {
  /// Create state for widget
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends AbstractStatefulWidgetState<App> {
  static AppState get instance => _instance;

  static late AppState _instance;

  /// State initialization
  @override
  void initState() {
    _instance = this;

    super.initState();
  }

  /// Create view layout from ui.widgets
  @override
  Widget buildContent(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Material(
      child: CoreApp(
        title: 'Clean',
        initializationUi: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: Container(
                child: Center(),
              ),
            );
          },
        ),
        initialScreenRoute: LoginScreen.ROUTE,
        //TODO route name of first screen after app init
        initialScreenRouteArguments: <String, String>{'router-fade-animation': '1'},
        onGenerateRoute: AppRouter.onGenerateRoute,
        builder: appThemeBuilder,
        theme: ThemeData(
          backgroundColor: Colors.white,
          primaryColor: kColorPrimary,
          accentColor: kColorSecondary,
          shadowColor: kColorShadow,
        ),
        snapshot: AppDataStateSnapshot(),
        preferencesOptions: PreferencesOptions(),
        mainDataProviderOptions: MainDataProviderOptions(
          mockUpOptions: MockUpOptions(),
          httpClientOptions: HTTPClientOptions(
            hostUrl: 'https://jsonplaceholder.typicode.com', //TODO correct API url for BE
          ),
          //TODO MockUpSource is not yet implemented
        ),
      ),
    );
  }
}

class AppDataStateSnapshot extends AbstractAppDataStateSnapshot {

  late LoginManagerModule loginManagerModule;
  late SecurePreferencesModule securePreferencesModule;

  /// AppDataState initialization
  AppDataStateSnapshot(){
    loginManagerModule = LoginManagerModule();
    securePreferencesModule = SecurePreferencesModule();
  }

}
