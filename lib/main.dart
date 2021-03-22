import 'package:flutter/material.dart';
import 'package:guma/views/home/home.view.dart';
import 'package:guma/views/init/splash.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}
