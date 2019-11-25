import 'dart:io';

import 'package:esof/questionsDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int sessionCode = 0;
String username;
List<Widget> children;


class QuestionsPageAdmin extends StatefulWidget {
  QuestionsPageAdmin(int code, String user) {
    sessionCode = code;
    username = user;
    children = [
      Padding(padding: const EdgeInsets.only(top: 20)),
      Text("Session",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      Image.asset('assets/signUpLine.png')
    ];
  }
  @override
  State<StatefulWidget> createState() {
    return QuestionsPageState();
  }
}

class QuestionsPageState extends State<QuestionsPageAdmin> {

  final TextEditingController t1 = new TextEditingController();

  @override
  void initState() {
    super.initState();
    displayQuestions();
  }

  displayQuestions() async{
    List<Question> questions = await retrieveQuestions(sessionCode);
    for(Question question in questions) {
      children.add(Padding(padding: const EdgeInsets.only(top: 10)));
      children.add(QuestionBox(question.text, question.user));
    }
    setState(() {});
  }

  _submitQuestion(BuildContext context, String text) {
    if (text.length == 0)
      return;
    Question question = Question(username, text, 0, sessionCode);
    addQuestion(question);
    setState(() {
      children.add(Padding(padding: const EdgeInsets.only(top: 10)));
      children.add(QuestionBox(text, username));
      t1.text = '';
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //displayQuestions();
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
                  onPressed: () => _submitQuestion(context, t1.text),
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
  QuestionBox(this.question, this.username);

  final String question;
  final String username;

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
                Text(username),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    print(children.length);
                    children.remove(this);
                    print(children.length);
                  },),
                Upvote(),
                Padding(padding: EdgeInsets.only(right: 10))
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
  // ignore: non_constant_identifier_names
  int _num_votes = 132;
  bool liked = false;

  _pressed() {
    setState(() {
      if (liked)
        _num_votes--;
      else _num_votes++;
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
          onPressed: () => _pressed(),
        ),
        Text('$_num_votes'),
      ],
    );
  }
}
