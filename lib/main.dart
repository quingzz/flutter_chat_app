// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './widgets/sidebar_drawer.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  // This widget is the root of your application. Aka the entry point
  // Used for setting the theme for the app
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Sample chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SidebarDrawer(),
      ),
    );
  }
}
