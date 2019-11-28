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
    qps.updateQuestions();
  }

  setActive(){
    qps.setActive();
  }

  bool getActive() {
    return qps.getActive();
  }

  @override
  State<StatefulWidget> createState() {
    return qps;
  }
}

class QuestionsPageState extends State<QuestionsPage> {

  QuestionsPageState();

  List list = List();
  bool isLoading = false;
  int cnt = 0;
  String sessionNumber;
  List<Widget> children = [];
  String questions;
  bool active;

  @override
  void initState() {
    super.initState();
    updateQuestions();
  }

  setActive() {
    active = true;
  }

  bool getActive() {
    return active;
  }

  setSessionNumber(String sN) {
    sessionNumber = sN;
  }  

  fetchData() async {
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

  updateQuestions() async{
    print("Updating Questions");
    children = [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text("Session " + sessionNumber.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80)),
            ],
          ),
      Image.asset('assets/signUpLine.png')
    ];
    await fetchData();
    setState(() {
      int maxQuestionsDisplayed = 2;
      int cnt = 0;
      for (int index = 0; index < list.length; index++) {
        if ((list[index]["session"] == sessionNumber) && (cnt < maxQuestionsDisplayed)){
          children.add(Padding(padding: const EdgeInsets.only(top: 10)));
          if (list[index]["likesCount"] == null)
            children.add(QuestionBox(list[index]["username"],(list[index]["question"] + "\n"),"0"));
          else children.add(QuestionBox(list[index]["username"],(list[index]["question"] + "\n"),list[index]["likesCount"]));
          cnt++;
        }
      }
      children.add(Padding(padding: const EdgeInsets.only(top: 10)));
      children.add(SizedBox(
                    width: 300,
                    height: 80,
                    child: RaisedButton(
                      onPressed: () {
                        active = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SessionScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Text(
                          'Quit Session',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                          )
                        ]
                      )
                    )
                  ));
    });
    print("Questions Updated");
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

class QuestionBox extends StatelessWidget {
  QuestionBox(this.username,this.question, this.numUpvotes);

  final String question, username, numUpvotes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(question,
                maxLines: 3,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 70),
              ),
            ),
            Row(
              children: <Widget>[
                Image.asset('assets/userLogo.png',width: 60,height: 60),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                Expanded(
                  child: Text(username,
                    style: TextStyle(
                      fontSize: 70)),
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
  final String numVotes;
  @override
  State<StatefulWidget> createState() {
    return UpvoteState(numVotes);
  }
}

class UpvoteState extends State<Upvote> {
  
  UpvoteState(this.numVotes);
  final String numVotes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.favorite, size: 60),
        SizedBox(width: 10),
        Text(numVotes,
          style: TextStyle(
            fontSize: 70),),
      ],
    );
  }
}
