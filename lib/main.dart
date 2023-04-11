import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Screens/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>AuthController() );
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: login(),
    );
  }
}