import 'package:flutter/material.dart';

import 'package:login_view/core/constant/route_name.dart';
import 'package:login_view/views/home_view.dart';
import 'package:login_view/views/login_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginView(),
      routes: {
        RouteName.LOGIN: (context) => LoginView(),
        RouteName.HOME: (context) => HomeView(),
      },
    );
  }
}
