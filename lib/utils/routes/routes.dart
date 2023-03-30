import 'package:flutter/material.dart';
import 'package:mvvm_tech_brothers/utils/routes/routes_name.dart';
import 'package:mvvm_tech_brothers/view/home_screen.dart';
import 'package:mvvm_tech_brothers/view/login_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // function will return a Route, generateRoute(RouteSetting accepts a String parameter)
    switch(settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginView());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Default Page"),
            ),
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });
    }
  }
}