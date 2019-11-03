import 'package:flutter/material.dart';
import 'package:mecdrive_app/HomeScreen/homeScreen.dart';
import 'package:mecdrive_app/MyRides/myRides.dart';
import 'package:mecdrive_app/SplashScreen/splashScreen.dart';
import 'package:mecdrive_app/auth/registerUser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MecDrive',
      //test phase
      home: HomeScreen(), 
      routes: {
        '/homescreen' : (context) => HomeScreen(),
        '/register'   : (context) => SignUp(),
        '/myrides'    : (context) => MyRides(),
      },
    );
  }
}
