// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

// import 'dart:async';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kebudayaan/screen_pages/page_login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    ///Wait 3 seconds and navigate to home page
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PageLogin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Stack(
        children: <Widget>[
          // Centered content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'gambar/logo.png',
                  scale: 1.0,
                ),
                SizedBox(height: 120.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
