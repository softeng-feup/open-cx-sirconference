import 'package:esof/accountManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  TextEditingController pwConfirmController = new TextEditingController();
  TextEditingController safequestionController = new TextEditingController();

  var inputUser;
  var inputPw;
  var inputConfirmPw;
  var safeQuestion;

  bool _existsUsername = true;

  register() async {
    inputUser = usernameController.text;
    inputPw = pwController.text;
    inputConfirmPw = pwConfirmController.text;
    safeQuestion = safequestionController.text;
    if (inputPw != inputConfirmPw) {passwordsNoMatch(); return;}
    await verifyUsername();
    if (!_existsUsername)
      addUser(SignUpRequest(inputUser, inputPw, safeQuestion));
  }

  asyncVerification() async {
    _existsUsername = await checkIfUsernameExists(inputUser);
  }

  verifyUsername() async {
    print('chegou ao assync v');
    await asyncVerification();
    print('passou o assync');
    if (_existsUsername) {
      return showDialog(
          context: context,
          builder: (context)
          {
            return AlertDialog(
              title: Text('  Username already exists',
                  style: TextStyle(fontSize: 18)),
            );
          });
    }
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
                  controller: pwConfirmController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 10),
                      hintText: 'repeat password',
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
                  controller: safequestionController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 10),
                      hintText: 'favorite color',
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
                      onPressed: register,
                      child: Text(
                        'Sign up',
                      ))),
            ],
          )),
      Padding(
        padding: const EdgeInsets.only(top: 15),
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
        Text('Sign up with Facebook',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ]),
    ])));
  }
}
