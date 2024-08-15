import 'package:flutter/material.dart';

class NavigationManager {
  static NavigationManager? _instance;
  static NavigationManager get instance {
    _instance ??= NavigationManager._init();
    return _instance!;
  }

  NavigationManager._init();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  dynamic goBack([dynamic popValue]) {
    return navigatorKey.currentState!.pop(popValue);
  }

  Future<dynamic> navigateToPage(Widget page) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => page));
  }

  Future<dynamic> navigateToPageClear(Widget page) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  Future<dynamic> replace(Widget page, {dynamic arguments}) async =>
      navigatorKey.currentState!
          .pushReplacement(MaterialPageRoute(builder: (_) => page));
}
