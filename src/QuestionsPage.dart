import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuestionsPageState();
  }
}

class QuestionsPageState extends State<QuestionsPage> {
  void addData() {
    var url = "https://esof.000webhostapp.com/addData.php";
    http.post(url,
        body: {"id": '9', "username": "UserXX", "question" : t1.text});
  }

  final TextEditingController t1 = new TextEditingController();
  List<Widget> children = [
    Padding(padding: const EdgeInsets.only(top: 20)),
    Text("Session",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Image.asset('assets/signUpLine.png')
  ];

  _submitQuestion(BuildContext context) {
    addData();
    setState(() {
      children.add(Padding(padding: const EdgeInsets.only(top: 10)));
      children.add(QuestionBox(t1.text));
      t1.text = '';
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
            QuestionButton(onPressed: () => _displayDialog(context)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: children,
            ),
          ),
        ));
  }

  _displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Write your question'),
            content: TextField(
              decoration: InputDecoration(hintText: 'Type here'),
              controller: t1,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    t1.text = '';
                  },
                  child: Text('CANCEL')),
              FlatButton(
                  onPressed: () => _submitQuestion(context),
                  child: Text('SUBMIT'))
            ],
          );
        });
  }
}

class QuestionButton extends StatelessWidget {
  QuestionButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.grey,
      splashColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Add a question',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}

class QuestionBox extends StatelessWidget {
  QuestionBox(this.question);

  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              width: 400,
              child: Text(question),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Row(
              children: <Widget>[
                Text('User X'),
                SizedBox(width: 240),
                Upvote(),
              ],
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}

class Upvote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpvoteState();
  }
}

class UpvoteState extends State<Upvote> {
  int _num_votes = 132;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.favorite),
        SizedBox(width: 3),
        Text('$_num_votes'),
      ],
    );
  }
}
