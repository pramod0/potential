import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/screens/dashboard.dart';
import 'package:potential/screens/splash.dart';

import 'app_routes.dart';

getPlatformDependentPageRoute(Widget scaffoldWidget) {
  return TargetPlatform.android == defaultTargetPlatform
      ? MaterialPageRoute(builder: (context) => scaffoldWidget)
      : CupertinoPageRoute(
          builder: (context) => scaffoldWidget,
        );
}

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return getPlatformDependentPageRoute(const Splash());
      case AppRoutes.dashboard:
        return getPlatformDependentPageRoute(const Dashboard());
      case AppRoutes.schemeDetails:
      //todo: get dependency debar scheme page bro
      // return getPlatformDependentPageRoute(const SchemeSummaryScreen(schemeKey: schemeKey, schemeCurrent: schemeCurrent));
      default:
        return null;
    }
  }
}
