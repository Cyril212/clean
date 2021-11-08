
import 'package:clean/ui/screens/WidgetGalleryScreen.dart';
import 'package:clean/ui/screens/dashboard/DashboardScreen.dart';
import 'package:clean/ui/screens/forgotPassword/ForgotPasswordScreen.dart';
import 'package:clean/ui/screens/jobDetail/JobDetailScreen.dart';
import 'package:clean/ui/screens/login/LoginScreen.dart';
import 'package:clean/ui/screens/settings/SettingsScreen.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

/// Generate Route with Screen for RoutingArguments from Route name
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final arguments = settings.name?.routingArguments;

  if (arguments != null) {
    switch (arguments.route) {
      case JobDetailScreen.ROUTE:
        return createRoute((BuildContext context) => JobDetailScreen(), settings);
      case SettingsScreen.ROUTE:
        return createRoute((BuildContext context) => SettingsScreen(), settings);
      case DashboardScreen.ROUTE:
        return createRoute((BuildContext context) => DashboardScreen(), settings);
      case LoginScreen.ROUTE:
        return createRoute((BuildContext context) => LoginScreen(), settings);
      case ForgotPasswordScreen.ROUTE:
        return createRoute((BuildContext context) => ForgotPasswordScreen(), settings);
      case WidgetGalleryScreen.ROUTE:
        return createRoute((BuildContext context) => WidgetGalleryScreen(), settings);
      default:
        throw Exception('Implement OnGenerateRoute in app');
    }
  }

  throw Exception('Arguments not available');
}