import 'package:esof/LogInPage.dart';
import 'package:esof/QuestionsPage.dart';
import 'package:esof/sessionsManegement.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'AdminQuestionsPage.dart';
import 'EditProfilePage.dart';

String username;

void alertAnonymous(BuildContext context) {
  showDialog(
      context: context,
      builder: (context)
      {
        return AlertDialog(
          title: Text('     You are not logged in!',
              style: TextStyle(fontSize: 18)),
        );
      });
}

class SessionScreen extends StatelessWidget {
  final String _username;

  SessionScreen(this._username) {
    username = this._username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Conference\nManager',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    fontFamily: 'CustomFont'),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Logged in as :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'CustomFont'),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                  ),
                  Image.asset(
                    'assets/userLogo.png',
                    height: 70,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                  ),
                  Text(
                    _username,
                    key: const Key('user'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'CustomFont'),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Center(
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      onPressed: () {
                        if (username != "Anonymous") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                EditProfilePage(username)),
                          );
                        }
                        else {
                          alertAnonymous(context);
                        }
                      },
                      child: new Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  'assets/settings.png',
                                )
                            )
                        )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: InputSection('Enter session code here'),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 90),
            ),
            AdminSessionManagement(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class UserSection extends StatelessWidget {
  final Color _color;
  final String _text;

  UserSection(this._color, this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _color,
      ),
      child: Center(
        child: Text(_text),
      ),
    );
  }
}

class InputSection extends StatefulWidget {
  final String _text;

  InputSection(this._text);

  @override
  InputState createState() => new InputState(_text);
}

class InputState extends State<InputSection> {
  final String _text;
  final TextEditingController controller = new TextEditingController();

  InputState(this._text);

  joinSession() async {
    int code = int.parse(controller.text);
    var questionsPage;
    bool admin = await isAdmin(code.toString(), username);
    if(admin)
      questionsPage = new AdminQuestionsPage(code, username);
    else questionsPage = new QuestionsPage(code, username);
    questionsPage.setActive();
    Timer.periodic(Duration(seconds: 15), (timer) {
      if (questionsPage.getActive())
        questionsPage.getQuestions();
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => questionsPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
                key: const Key('session code'),
                controller: controller,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 10),
                    hintText: 'Session Code',
                    hintStyle: TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0.1))))),
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          SizedBox(
              width: 70, // match_parent
              height: 44,
              child: RaisedButton(
                  key: const Key('Go'),
                  onPressed: joinSession,
                  child: Text(
                    'Go',
                  ))),
        ],
      ),
    );
  }
}

class AdminSessionManagement extends StatelessWidget {
  final TextEditingController t1 = new TextEditingController();
  final TextEditingController t2 = new TextEditingController();

  _displayCreateDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create a new session'),
            content: TextField(
              decoration: InputDecoration(hintText: 'Session Code'),
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
                  onPressed: () {
                    createSession(t1.text, username);
                    Navigator.of(context).pop();
                  },
                  child: Text('CREATE'))
            ],
          );
        });
  }

  _displayDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete a session'),
            content: TextField(
              decoration: InputDecoration(hintText: 'Session Code'),
              controller: t2,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    t2.text = '';
                  },
                  child: Text('CANCEL')),
              FlatButton(
                  onPressed: () {
                    deleteSession(t2.text, username);
                    Navigator.of(context).pop();
                  },
                  child: Text('DELETE'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15),
        ),
        SizedBox(
          height: 50,
          child: RaisedButton(
              onPressed: () {
                if (username != "Anonymous")
                  _displayCreateDialog(context);
                else alertAnonymous(context);
              },
              child: Text(
                'Create a new session',
                style: TextStyle(fontSize: 15),
              )),
        ),
        Padding(padding: const EdgeInsets.only(right: 10)),
        Spacer(),
        SizedBox(
          height: 50,
          child: RaisedButton(
              onPressed: () {
                if (username != "Anonymous")
                  _displayDeleteDialog(context);
                else alertAnonymous(context);
              },
              child: Text(
                'Delete a session',
                style: TextStyle(fontSize: 15),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30),
        )
      ],
    );
  }
}
