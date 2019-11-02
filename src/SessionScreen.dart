import 'package:flutter/material.dart';

void main() => runApp(SessionScreen("Jack Person"));

class SessionScreen extends StatelessWidget {
  final String _username;
  SessionScreen(this._username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Container(
              padding: EdgeInsets.only(top: 100),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'CustomFont'),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Image.asset(
                    'assets/settings.png',
                    height: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100) ,
              child: InputSection('Enter session code here'),
            ),
          ],
        ),
        backgroundColor: Colors.white,
    );
  }
}

class UserSection extends StatelessWidget {
  final Color _color;
  final String _text;
  UserSection(this._color,this._text);

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

class InputSection extends StatefulWidget{
  final String _text;
  InputSection(this._text);
  @override
  InputState createState() => new InputState(_text);
}

class InputState extends State<InputSection>{

  final String _text;
  final TextEditingController controller = new TextEditingController();
  String code = "";
  InputState(this._text);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
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
          Padding(
              padding: EdgeInsets.only(right: 10)
          ),
          SizedBox(
              width: 70, // match_parent
              height: 44,
              child: RaisedButton(
                  onPressed: (){},
                  child: Text(
                    'Go',
                  ))),
        ],
      ),
    );
  }
}
