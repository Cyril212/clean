import 'package:tch_appliable_core/tch_appliable_core.dart';

abstract class AppScreen extends AbstractScreen {}

abstract class AppScreenState<T extends AppScreen> extends AbstractScreenState<T> {
  @override
  Widget? createBottomBar(BuildContext context) => null;

  @override
  Widget? createDrawer(BuildContext context) => null;
}
