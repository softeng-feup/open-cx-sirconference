import 'package:esof/accountManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ForgotPassword extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController securityAnswerController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  TextEditingController pwConfirmController = new TextEditingController();

  var username;
  var securityAnswer;
  var inputPw;
  var inputConfirmPw;

  resetPassword() async {
    username = usernameController.text;
    securityAnswer = securityAnswerController.text;
    inputPw = pwController.text;
    inputConfirmPw = pwConfirmController.text;
    if (inputPw != inputConfirmPw) {passwordsNoMatch(); return;}
    bool success = await reooverPassword(username, inputPw, securityAnswer);
    if(!success)
      wrongSecAnswer();
  }

  wrongSecAnswer() {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            content: Text('Wrong security answer',
                style: TextStyle(fontSize: 20)),
          );
        });
  }


  passwordsNoMatch() {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            content: Text('  Passwords don\'t match',
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
                padding: const EdgeInsets.only(top: 50),
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
                      Text('Password recovery',
                      style:
                      TextStyle(fontFamily: 'CustomFont', fontSize: 27, fontWeight: FontWeight.bold),),
                      Padding(padding: EdgeInsets.only(top: 30),),
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
                          controller: securityAnswerController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10),
                              hintText: 'security answer',
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
                      TextField(
                          controller: pwConfirmController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10),
                              hintText: 'repeat new password',
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
                              onPressed: resetPassword,
                              child: Text(
                                'Submit',
                              ))),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
              ),
            ])));
  }
}
