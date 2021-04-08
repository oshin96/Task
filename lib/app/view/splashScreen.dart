import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:task/app/view/employeeListPage.dart';

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomePage(),
        title: Text(
          'Welcome To SplashScreen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
        ),
        image: Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.lime,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.black);
  }
}
