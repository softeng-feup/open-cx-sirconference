import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_app/SessionScreen.dart';

class QuestionsPage extends StatefulWidget {

  final QuestionsPageState qps = new QuestionsPageState();

  setSessionNumber(String sN){
    qps.setSessionNumber(sN);
  }

  updateQuestions() {
    qps._updateQuestions();
  }

  @override
  State<StatefulWidget> createState() {
    return qps;
  }
}

class QuestionsPageState extends State<QuestionsPage> {

  QuestionsPageState();

  List list = List();
  var isLoading = false;
  var cnt = 0;
  String sessionNumber;

  setSessionNumber(String sN) {
    sessionNumber = sN;
  }

  List<Widget> children = [];
  String questions;

  _fetchData() async {
    setState(() {
      isLoading = true; 
    });
    final url = "https://esof.000webhostapp.com/getQuestions.php";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      list = json.decode(response.body) as List;
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

_updateQuestions() async{
    print("Updating Questions");
    children = [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text("Session " + sessionNumber.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
      Image.asset('assets/signUpLine.png')
    ];
    await _fetchData();
    setState(() {
      int maxQuestionsDisplayed = 10;
      if (list.length < maxQuestionsDisplayed) maxQuestionsDisplayed = list.length;
      for (int index = 0; index < maxQuestionsDisplayed; index++) {
        if (list[index]["session"] == sessionNumber){
          children.add(Padding(padding: const EdgeInsets.only(top: 10)));
          children.add(QuestionBox(list[index]["username"],(list[index]["question"] + "\n"),5));
        }
      }
      children.add(Padding(padding: const EdgeInsets.only(top: 10)));
      children.add(SizedBox(
                    width: 120, // match_parent
                    height: 44,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SessionScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Text(
                          'Quit Session',)
                        ]
                      )
                    )
                  ));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: isLoading
          ? Center (child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children:  children,
                )
              ),
            )
    );
  }
}

class QuestionButton extends StatelessWidget {
  QuestionButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.grey,
      splashColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Update Questions',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}

class QuestionBox extends StatelessWidget {
  QuestionBox(this.username,this.question, this.numUpvotes);

  final String question, username;
  final int numUpvotes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(question)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              children: <Widget>[
                Image.asset('assets/userLogo.png',width: 30,height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                Expanded(
                  child: Text(username),
                ),
                Upvote(numUpvotes)
              ],
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}

class Upvote extends StatefulWidget {
  Upvote(this.numVotes);
  final int numVotes;
  @override
  State<StatefulWidget> createState() {
    return UpvoteState(numVotes);
  }
}

class UpvoteState extends State<Upvote> {
  
  UpvoteState(this.numVotes);
  final int numVotes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.favorite),
        SizedBox(width: 3),
        Text('$numVotes'),
      ],
    );
  }
}
