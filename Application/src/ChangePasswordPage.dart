import 'package:esof/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Authentication.dart';

String username;

class ChangePasswordPage extends StatefulWidget {
  final String _username;
  ChangePasswordPage(this._username) {
    username = this._username;
  }
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordState();
  }
}

class ChangePasswordState extends State<ChangePasswordPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  TextEditingController newpwController = new TextEditingController();

  var inputUser;
  var inputPw;
  var inputNewPw;

  bool _authenticated = false;

  changePassword() async{
    inputUser = usernameController.text;
    inputPw = pwController.text;
    inputNewPw = newpwController.text;
    if (inputPw == inputNewPw) {samePassword(); return;}
    print(inputUser);
    print(inputPw);
    await authenticate();
    if (_authenticated)
      updatePassword(inputUser, inputNewPw);
  }

  asyncAuthenticate() async {
    var inputUser = usernameController.text;
    var inputPw = pwController.text;
    LogInRequest req = new LogInRequest(inputUser, inputPw);
    bool authenticated = await processLogInRequest(req);
    _authenticated = authenticated;
  }

  authenticate() {
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

  samePassword() {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            content: Text('  Passwords are equal. Try to change into a different password',
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
                          controller: newpwController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10),
                              hintText: 'new password',
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
                              onPressed: changePassword,
                              child: Text(
                                'Save',
                              ))),
                    ],
                  )),
            ])));
  }
}
