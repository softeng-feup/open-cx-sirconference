import 'package:esof/SignUpPage.dart';
import 'package:esof/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:async';
import 'SessionScreen.dart';

class LogInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInPageState();
  }
}

class LogInPageState extends State<LogInPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();

  bool _authenticated = true;
  bool connected = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  void checkConnectivity() {
    bool arrived = false;
    connected = false;
    var cancellableOperation = CancelableOperation.fromFuture(
      getConnectionStatus(),
      onCancel: () => {},
    );
    cancellableOperation.value.then((value) => {
      connected = value,
      arrived = true,
    });
    Timer(Duration(seconds: 4), () async{
      if (!arrived) {
        cancellableOperation.cancel();
      }
      if (!connected) _showNoConnectionDialog();
    });
  }

  Future<bool> getConnectionStatus() async{
    final url = "https://esof.000webhostapp.com/getQuestions.php";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void _showNoConnectionDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("No Internet Connection"),
          content: new Text("Check your internet connection."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  asyncAuthenticate() async {
    var inputUser = usernameController.text;
    var inputPw = pwController.text;
    LogInRequest req = new LogInRequest(inputUser, inputPw);
    bool authenticated = await processLogInRequest(req);
    _authenticated = authenticated;
    if (authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SessionScreen(inputUser)),
        );
    }
  }

  authenticate() async {
    await asyncAuthenticate();

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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 5),
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
                                  const BorderRadius.all(
                                      Radius.circular(0.1))))),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                      ),
                      SizedBox(
                          width: double.infinity, // match_parent
                          child: RaisedButton(
                              onPressed: authenticate,
                              child: Text(
                                'Log in',
                              ))),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 5),
              ),
              Text('Forgot your password?',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
              ),
              Text('or', style: TextStyle(color: Colors.black, fontSize: 18)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
              ),
              RawMaterialButton(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SessionScreen("Anonymous")),
                    );
                },
                child: Text('Log in as guest',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
              ),
              Image.asset('assets/signUpLine.png'),
              Padding(
                padding: const EdgeInsets.only(top: 15),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Don\'t have an account?',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                    ),
                    RawMaterialButton(
                      child: Text('Sign up!',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 18,
                              decoration: TextDecoration.underline)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                    )
                  ])
            ])));
  }
}