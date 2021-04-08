import 'package:flutter/material.dart';
import 'package:task/app/view/employeeListPage.dart';
import 'app/view/detailsPage.dart';
import 'app/view/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MySplashScreen(),
    );
  }
}
