import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomePage(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate some initialization or loading time with Future.delayed
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 400,
              width: 400,
            ), // Replace this with your app logo
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
