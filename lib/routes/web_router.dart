
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_dashboard/ui/screens/login.dart';
import 'package:school_dashboard/ui/screens/parents/add_parent.dart';


class WebRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;
      case '/add_parent':
        return MaterialPageRoute(
          builder: (_) => add_parent(),
        );

      default:
        return null;
    }
  }
}
