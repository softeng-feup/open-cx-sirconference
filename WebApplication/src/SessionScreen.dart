import 'package:flutter/material.dart';
import 'QuestionsPage.dart';
import 'dart:async';

class SessionScreen extends StatelessWidget {
  SessionScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Container(
              child: Text(
                'Conference\nManager',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                    fontFamily: 'CustomFont'),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: InputSection(),
            ),
          ],
        ),
        backgroundColor: Colors.white,
    );
  }
}

class InputSection extends StatefulWidget{
  InputSection();
  @override
  InputState createState() => new InputState();
}

class InputState extends State<InputSection>{

  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              style: TextStyle(
                      fontSize: 50),
              controller: controller,
              keyboardType: TextInputType.visiblePassword,
              obscureText: false,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 10),
                  hintText: 'Session Code',
                  hintStyle: TextStyle(
                      fontFamily: 'CustomFont',
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(0.1))))),
          ),
          Padding(
              padding: EdgeInsets.only(right: 10)
          ),
          SizedBox(
              width: 200,
              height: 80,
              child: RaisedButton(
                  onPressed: () {
                    if (controller.text != "") {
                      final QuestionsPage questionsPage = new QuestionsPage();
                      questionsPage.setSessionNumber(controller.text);
                      questionsPage.setActive();
                      Timer.periodic(Duration(seconds: 20), (timer) {
                        if (questionsPage.getActive())
                          questionsPage.updateQuestions();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => questionsPage),
                      );
                    }
                  },
                  child: Text(
                    'Go',
                    style: TextStyle(
                      fontFamily: 'CustomFont',
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                  ))),
        ],
      ),
    );
  }
}

