import 'dart:collection';
import 'dart:convert';

import 'package:esof/QuestionsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInPageState();
  }
}

class LogInPageState extends State<LogInPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();

  List data;

  @override
  void initState() {
    getData();
  }

  authenticate() {
    setState(() {
      var inputUser = usernameController.text;
      var inputPw = pwController.text;
      if (checkAccount(data, inputUser, inputPw)) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionsPage()),
        );
      }
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
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Image.asset(
          'assets/fbLogo.png',
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
        ),
        Text('Login with Facebook',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ]),
      Padding(
        padding: const EdgeInsets.only(top: 70),
      ),
      Image.asset('assets/signUpLine.png'),
      Padding(
        padding: const EdgeInsets.only(top: 15),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text('Don\'t have an account?',
            style: TextStyle(color: Colors.black, fontSize: 18)),
        Padding(
          padding: const EdgeInsets.only(right: 10),
        ),
        Text('Sign up!',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
                decoration: TextDecoration.underline))
      ])
    ])));
  }

  Future getData() async {
    var url = 'https://esof.000webhostapp.com/get.php';
    http.Response response = await http.get(url);
    data = jsonDecode(response.body);
  }

  checkAccount(List data, String username, String password) {
    for (var acc in data) {
      acc = acc.toString();
      if (acc.contains(username + ',') && acc.contains(password + ','))
        return true;
    }
    return false;
  }
}