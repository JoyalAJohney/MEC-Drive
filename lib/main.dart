import 'package:flutter/material.dart';
import 'package:mecdrive_app/HomeScreen/homeScreen.dart';
import 'package:mecdrive_app/auth/registerUser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MecDrive',
      //test phase
      home: SignUp(), 
      routes: {
        '/homescreen' : (context) => HomeScreen(),
      },
    );
  }
}