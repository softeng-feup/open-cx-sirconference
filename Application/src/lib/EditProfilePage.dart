import 'package:esof/ChangePasswordPage.dart';
import 'package:esof/ChangeUsernamePage.dart';
import 'package:esof/accountManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Authentication.dart';

String username;

class EditProfilePage extends StatefulWidget {
  final String _username;
  EditProfilePage(this._username) {
    username = this._username;
  }
  @override
  State<StatefulWidget> createState() {
    return EditProfilePageState();
  }
}

class EditProfilePageState extends State<EditProfilePage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  TextEditingController pwConfirmController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
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
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'CustomFont'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                    ),
                    SizedBox(
                        width: double.infinity, // match_parent
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChangeUsernamePage(username)),
                              );
                            },
                            child: Text(
                              'Change username',
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                    ),
                    SizedBox(
                        width: double.infinity, // match_parent
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChangePasswordPage(username)),
                              );
                            },
                            child: Text(
                              'Change password',
                            ))),
                  ],
                )),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
