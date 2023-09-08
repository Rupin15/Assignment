import 'package:flutter/material.dart';
import 'package:assignment/pages/details_page.dart';
import 'package:assignment/pages/nav_pages/main_page.dart';
import 'package:assignment/pages/welcome_page.dart';
import 'package:assignment/services/data_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:WelcomePage(),

    );
  }
}