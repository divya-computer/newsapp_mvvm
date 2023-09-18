import 'package:flutter/material.dart';
import 'package:newsapp_mvvm/view/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'News Application',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
