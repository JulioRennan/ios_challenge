import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ios_challenge/view/home_screen.dart';
import 'package:ios_challenge/view/repository_view/repository_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
