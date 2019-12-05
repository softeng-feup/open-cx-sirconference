import 'package:esof/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Authentication.dart';

String username;

class ChangeUsernamePage extends StatefulWidget {
  final String _username;
  ChangeUsernamePage(this._username) {
    username = this._username;
  }
  @override
  State<StatefulWidget> createState() {
    return ChangeUsernameState();
  }
}

class ChangeUsernameState extends State<ChangeUsernamePage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  TextEditingController newusernameController = new TextEditingController();

  var inputUser;
  var inputPw;
  var inputNewUser;

  bool _authenticated = true;

  changeUsername() async{
    inputUser = usernameController.text;
    inputPw = pwController.text;
    inputNewUser = newusernameController.text;
    if (inputUser == inputNewUser) {sameUserName(); return;}
    await authenticate();
    if (_authenticated)
      updateUsername(inputUser, inputNewUser);
  }

  asyncAuthenticate() async {
    var inputUser = usernameController.text;
    var inputPw = pwController.text;
    LogInRequest req = new LogInRequest(inputUser, inputPw);
    bool authenticated = await processLogInRequest(req);
    _authenticated = authenticated;
  }

  authenticate() async{
    setState(() {
      asyncAuthenticate();
    });
    if (!_authenticated) {
      pwController.text = '';
      return showDialog(
          context: context,
          builder: (context)
          {
            return AlertDialog(
              title: Text('Wrong username or password',
                  style: TextStyle(fontSize: 18)),
            );
          });
    }
  }

  sameUserName() {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            content: Text('  Usernames are equal. Try to change into a different username',
                style: TextStyle(fontSize: 20)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 100),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Conference\nManager',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                fontFamily: 'CustomFont'),
            textAlign: TextAlign.center,
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 60),
      ),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Column(
            children: <Widget>[
              TextField(
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 10),
                      hintText: 'username',
                      hintStyle: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(0.2),
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.only(top: 25),
              ),
              TextField(
                  controller: pwController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 10),
                      hintText: 'password',
                      hintStyle: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(0.1))))),
              Padding(
                padding: const EdgeInsets.only(top: 25),
              ),
              TextField(
                  controller: newusernameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 10),
                      hintText: 'new username',
                      hintStyle: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(0.2),
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.only(top: 25),
              ),
              SizedBox(
                  width: double.infinity, // match_parent
                  child: RaisedButton(
                      onPressed: changeUsername,
                      child: Text(
                        'Save',
                      ))),
            ],
          )),
    ])));
  }
}
