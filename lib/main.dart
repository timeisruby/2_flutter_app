import 'package:flutter/material.dart';
import 'package:idea_app/screen/main_screen.dart';
import 'package:idea_app/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'idea App',
      initialRoute: '/',
      routes: {
        '/':(context)=> SplashScreen(),
        '/main':(context)=>MainScreen(),
      },
    );
  }
}
