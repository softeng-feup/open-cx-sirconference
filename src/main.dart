import 'package:esof/QuestionsPage.dart';
import 'package:esof/SessionScreen.dart';
import 'package:flutter/material.dart';
import 'LogInPage.dart';
import 'SignUpPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuestionsPage(),
    );
  }
}
