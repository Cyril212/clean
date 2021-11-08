import 'package:clean/model/dataRequest/AvailableJobListRequest.dart';
import 'package:clean/model/dataRequest/CompletedJobListRequest.dart';
import 'package:clean/model/dataRequest/CurrentJobListRequest.dart';
import 'package:clean/ui/screens/settings/SettingsScreen.dart';
import 'package:clean/ui/widgets/appbars/PrimaryAppBar.dart';
import 'package:clean/ui/widgets/tabs/TabBarWidget.dart';
import 'package:clean/ui/widgets/tabs/TabItemWidget.dart';
import 'package:flutter/material.dart';

import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../AppScreenState.dart';
import 'JobListWidget.dart';

class DashboardScreen extends AppScreen {
  static const String ROUTE = '/dashboard';

  @override
  State<AppScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends AppScreenState<DashboardScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  AbstractScreenStateOptions get options => AbstractScreenStateOptions.basic(screenName: 'Dashboard', title: 'Dashboard');

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget buildContent(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBarWidget(controller: tabController!, tabs: [
              TabItemWidget(
                title: 'Nové',
                description: '',
                tabIcon: 'assets/icons/illustration_available.svg',
              ),
              TabItemWidget(
                title: 'Moje',
                description: '',
                tabIcon: 'assets/icons/illustration_ongoing.svg',
              ),
              TabItemWidget(
                title: 'Hotovo',
                description: '',
                tabIcon: 'assets/icons/illustration_completed.svg',
              ),
            ]),
            Expanded(
              child: TabBarView(
                controller: tabController!,
                children: [
                  JobListWidget(listRequest: AvailableJobListRequest(userId: 0)),
                  JobListWidget(listRequest: CurrentJobListRequest(userId: 1)),
                  JobListWidget(listRequest: CompletedJobListRequest(userId: 2)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? createAppBar(BuildContext context) {
    return PrimaryAppbar(
      onPressed: () {
        pushNamed(context, SettingsScreen.ROUTE);
      },
    );
  }
}
