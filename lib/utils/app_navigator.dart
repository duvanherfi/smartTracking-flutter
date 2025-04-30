import 'package:stacked_services/stacked_services.dart';

class AppNavigator extends NavigationService {
  pushReplaceWith(String route, {dynamic arguments}) =>
      replaceWith(route, arguments: arguments);

  pushReplacement(String route, {dynamic arguments}) =>
      pushNamedAndRemoveUntil(route, arguments: arguments);

  Future<dynamic> push(String route, {dynamic arguments}) async =>
      await navigateTo(
        route,
        arguments: arguments,
      );
}
