import 'package:flutter/material.dart';
import 'package:web_app/SessionScreen.dart';
//import 'QuestionsPage.dart';
//import 'dart:async';

int cnt = 0;

void main() {
  MyApp app = new MyApp();

  /* Timer.periodic(Duration(seconds: 1), (timer) {
    cnt++;
    if (cnt > 1) {
      timer.cancel();
    } else app.updateQuestions();
  });

  Timer.periodic(Duration(seconds: 20), (timer) {
    app.updateQuestions();
  }); */

  runApp(app);
}

class MyApp extends StatelessWidget {

  //final QuestionsPage questionsPage = new QuestionsPage("0");
  final SessionScreen sessionScreen = new SessionScreen();

  /* updateQuestions() {
    questionsPage.updateQuestions();
  } */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: sessionScreen,
    );
  }
}