import 'package:clean/core/AppTheme.dart';
import 'package:clean/ui/screens/login/LoginScreen.dart';
import 'package:clean/ui/widgets/appbars/SecondaryAppBar.dart';
import 'package:clean/ui/widgets/buttons/ContainedButtonWidget.dart';
import 'package:clean/ui/widgets/listTiles/OneLineListItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../../../App.dart';
import '../AppScreenState.dart';

class SettingsScreen extends AppScreen {
  static const String ROUTE = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends AppScreenState<SettingsScreen> {
  @override
  AbstractScreenStateOptions get options => AbstractScreenStateOptions.basic(screenName: 'Nastavení', title: 'Nastavení');

  String appVersion = '';

  @override
  firstBuildOnly(BuildContext context) {
    getAppVersion();
    super.firstBuildOnly(context);
  }

  getAppVersion() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setStateNotDisposed(() {
        appVersion = packageInfo.version;
      });
    });
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: kContentHorizontalPadding,
      child: Column(
        children: [
          SizedBox(height: 30),
          OneLineListItemWidget(
            label: 'Email',
            value: 'clean@clean.xyz',
          ),
          SizedBox(height: 26),
          OneLineListItemWidget(
            label: 'Verze aplikace',
            value: appVersion,
          ),
          SizedBox(height: 36),
          ContainedButtonWidget(
            text: 'Odhlásit se',
            prefixIconSvgAssetPath: 'assets/icons/icon_logout.svg',
            onTap: () {
              executeAsyncTask(() => AppDataState.of<AppDataStateSnapshot>(context)!.loginManagerModule.logout(context));
              pushNamedNewStack(context, LoginScreen.ROUTE);
            },
          )
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? createAppBar(BuildContext context) {
    return SecondaryAppBar(title: options.title);
  }
}
