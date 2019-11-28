import 'dart:io';

import 'package:esof/QuestionsPage.dart' as prefix0;
import 'package:esof/questionsDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int sessionCode = 0;
String username;
List<Widget> children;

class QuestionsPage extends StatefulWidget {
  QuestionsPage(int code, String user) {
    sessionCode = code;
    username = user;
  }

  @override
  State<StatefulWidget> createState() {
    return QuestionsPageState();
  }
}

class QuestionsPageState extends State<QuestionsPage> {
  QuestionsPageState() {
    children = [
      Padding(padding: const EdgeInsets.only(top: 20)),
      Text("Session",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      Image.asset('assets/signUpLine.png')
    ];
  }

  final TextEditingController t1 = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  getQuestions() async {
    List<Question> questions = await retrieveQuestions(sessionCode);
    for (Question question in questions) {
      children.add(QuestionBox(question));
    }
    setState(() {});
  }

  _submitQuestion(BuildContext context, String text) {
    if (text.length == 0) return;
    Question question = Question(username, text, 0, sessionCode);
    addQuestion(question);
    setState(() {
      children.add(QuestionBox(question));
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

class QuestionBox extends StatefulWidget {
  QuestionBox(this.question);

  final Question question;

  @override
  State<StatefulWidget> createState() {
    return QuestionBoxState(this.question);
  }
}

class QuestionBoxState extends State<QuestionBox> {
  QuestionBoxState(Question question) {
    this.username = question.user;
    this.question = question.text;
    this.likesCount = question.likesCount;
  }

  String question;
  String username;
  int likesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(top:10)),
        Container(
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
                    Upvote(likesCount),
                    Padding(padding: EdgeInsets.only(right: 10))
                  ],
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ],
    );
  }
}

class Upvote extends StatefulWidget {
  Upvote(this.likesCount);

  final int likesCount;

  @override
  State<StatefulWidget> createState() {
    return UpvoteState(likesCount);
  }
}

class UpvoteState extends State<Upvote> {
  UpvoteState(int likesCount) {
    this._num_votes = likesCount;
  }
  // ignore: non_constant_identifier_names
  int _num_votes;
  bool liked = false;

  _pressed() {
    setState(() {
      if (liked)
        _num_votes--;
      else
        _num_votes++;
      liked = !liked;

      updateLikes(_num_votes);
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
