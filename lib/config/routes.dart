import 'package:flutter/material.dart';
import 'package:machine_test_practice2/views/home_page.dart';
import 'package:machine_test_practice2/views/login_page.dart';

class Routes {
  Routes._();

  static const String homePage = '/home';
  static const String loginPage = '/login';
  
  static final dynamic route = <String, WidgetBuilder>{
    homePage: (context) => const HomePage(),
    loginPage: (context) => const LoginPage(),
  };

}