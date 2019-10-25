import 'package:flutter/material.dart';

void main() => runApp(SessionScreen("Jack Person"));

class SessionScreen extends StatelessWidget {
  final String _username;
  SessionScreen(this._username);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conference Manager',
      home: Scaffold(
/*        appBar: AppBar(
          title: Text('Conference Manager',
                      style: TextStyle(fontSize: 25,)
                      ),
        ),*/
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Container(
              margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: TextSection(Colors.white,'Conference Manager', 50),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: TextSection(Colors.white,'Current username:', 25),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextSection(Colors.white,_username, 25),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0) ,
              child: InputSection(Colors.white,' Enter session code here'),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  final Color _color;
  final String _text;
  final double _size;
  TextSection(this._color,this._text,this._size);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _color,
      ),

      child: Center(
        child: Text(_text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: _size,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
  final Color _color;
  final String _text;
  InputSection(this._color,this._text);
  @override
  InputState createState() => new InputState(_color,_text);
}

class InputState extends State<InputSection>{

  final Color _color;
  final String _text;
  final TextEditingController controller = new TextEditingController();
  String code = "";
  InputState(this._color,this._text);
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: _color,
      ),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(
                hintText: _text
              ),
              onSubmitted: (String code) {
                setState(() {
                  this.code = code;
                  print(code);
                });
                controller.text = "";
              },
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
