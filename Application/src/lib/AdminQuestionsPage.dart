import 'dart:io';

import 'package:esof/QuestionsPage.dart' as prefix0;
import 'package:esof/questionsDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int sessionCode = 0;
String username;
List<Widget> children;

class AdminQuestionsPage extends StatefulWidget {

  final QuestionsPageState qps = new QuestionsPageState();
  AdminQuestionsPage(int code, String user) {
    sessionCode = code;
    username = user;
  }

  getQuestions() {
    qps.getQuestions();
  }
  setActive(){
    qps.setActive();
  }
  bool getActive() {
    return qps.getActive();
  }

  @override
  State<StatefulWidget> createState() {
    return qps;
  }
}

class QuestionsPageState extends State<AdminQuestionsPage> {

  final TextEditingController t1 = new TextEditingController();

  bool active;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  setActive() {
    active = true;
  }
  bool getActive() {
    return active;
  }

  getQuestions() async {
    setState(() {
      isLoading = true;
    });
    List<Question> questions = await retrieveQuestions(sessionCode, username);

    children = [
      Padding(padding: const EdgeInsets.only(top: 20)),
      Text("Session " + sessionCode.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      Image.asset('assets/signUpLine.png')
    ];

    for (Question question in questions) {
      children.add(QuestionBox(question));
    }
    setState(() {
      isLoading = false;
    });
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
        body: isLoading
            ? Center (child: CircularProgressIndicator(),)
        :
        SingleChildScrollView(
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

  @override
  void dispose() {
    active = false;
    super.dispose();
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
    this.question = question;
  }

  Question question;

  bool visible = true;

  _eraseQuestion() {
    setState(() {
      visible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!visible) {
      return SizedBox.shrink();
    }
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
                  child: Text(question.text),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Row(
                  children: <Widget>[
                    Text(question.user),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _eraseQuestion();
                        deleteQuestion(
                            Question(question.user, question.text, question.likesCount, sessionCode));
                      },
                    ),
                    Upvote(question),
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
  Upvote(this.question);

  final Question question;

  @override
  State<StatefulWidget> createState() {
    return UpvoteState(question);
  }
}

class UpvoteState extends State<Upvote> {
  UpvoteState(Question question) {
    this.question = question;
    this.likesCount = question.likesCount;
  }
  // ignore: non_constant_identifier_names
  Question question;
  int likesCount;

  _pressed() {
    setState(() {
      if (question.liked) {
        question.likesCount--;
        likesCount--;
        decrementLikes(question, username);
      }
      else {
        question.likesCount++;
        likesCount++;
        incrementLikes(question, username);
        print('passou o increment');
      }
      question.liked = !question.liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(question.liked ? Icons.favorite : Icons.favorite_border),
          onPressed: () => _pressed(),
        ),
        Text('$likesCount'),
      ],
    );
  }
}
