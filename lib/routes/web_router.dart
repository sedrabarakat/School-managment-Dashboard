
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/ui/screens/home/dashboard_home.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/screens/login.dart';
import 'package:school_dashboard/ui/screens/parents/add_parent.dart';

import '../ui/screens/library/books_list.dart';


class WebRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;
      case '/home':
        return MaterialPageRoute(
          builder: (_) => Basic_Screen(),
        );


      default:
        return null;
    }
  }
}
