import 'dart:convert';
import 'package:esof/QuestionsPage.dart';
import 'package:http/http.dart' as http;

class Question {
  final user;
  final text;
  int likesCount;
  final session;
  bool liked;
  Question(this.user, this.text, int likesCount, this.session) {
    this.likesCount = likesCount;
    this.liked = false;
  }
}

/* Gets the questions from the database, processing the received data and returning it in the form of a list. */
Future<List<Question>> retrieveQuestions(int sessionCode, String username) async {
  var url1 = "https://esof.000webhostapp.com/getLikedQuestions.php?username=" + username;
  http.Response response = await http.get(url1);
  String data = json.decode(response.body).toString();
  List<String> questions = splitData(data);
  var url2 = "https://esof.000webhostapp.com/getNotLikedQuestions.php?username=" + username;
  http.Response response2 = await http.get(url2);
  String data2 = json.decode(response2.body).toString();
  List<String> questions2 = splitData(data2);
  List<Question> likedQuestions = parseQuestions(questions, sessionCode, true);
  List<Question> notLikedQuestions = parseQuestions(questions2, sessionCode, false);
  return likedQuestions + notLikedQuestions;

}

/* Receives a big string containing all the questions retrieved, splitting it into individual strings (one for each question). */
List<String> splitData(String data) {
  List<String> result = [];
  while(true) {
    int startIndex = data.indexOf('{');
    if (startIndex == -1)
      break;
    int endIndex = data.indexOf('}');
    result.add(data.substring(startIndex + 1, (endIndex - startIndex + 1)));
    data = data.substring(endIndex + 2);
  }
  return result;
}

/* Receives a string containing the data of a question, parsing it into an adequate struct. */
Question parseQuestion(String data, bool liked) {
  int usernameIndex = data.indexOf('username:') + 10; // index where the username string starts
  data = data.substring(usernameIndex); // now the username starts at position 0
  usernameIndex = data.indexOf(',') - 1; // index where the username string ends
  String username = data.substring(0, usernameIndex + 1);
  int questionIndex = data.indexOf('question:') + 10; // index where the question starts
  int sessionIndex = data.indexOf('session:');
  String question = data.substring(questionIndex, sessionIndex - 2); // now the question starts at position 0
  int likesIndex = data.indexOf('likesCount:');
  String likesPart = data.substring(likesIndex + 12);
  int sessionC = int.parse(data.substring(sessionIndex + 9, likesIndex - 2)); //
  int likesCount = 0;
  if(likesPart != 'null') likesCount = int.parse(likesPart);
  Question quest = new Question(username, question, likesCount, sessionC);
  quest.liked = liked;
  return quest;
}

/* Converts a list of Strings into a list of Questions. */
List<Question> parseQuestions(List<String> data, int code, bool liked) { //
  List<Question> questions = [];
  for (var element in data) {
    Question temp = parseQuestion(element, liked); //
    if(temp.session != code) //
      continue; //
    questions.add(parseQuestion(element, liked));
  }
  return questions;
}

/* Inserts a question into the database. */
void addQuestion(Question question) {
  var url = "https://esof.000webhostapp.com/addData.php";
  http.post(url,
      body: {"username": question.user, "question" : question.text, "session" : question.session.toString()});
}

/* Deletes a question from the database. */
void deleteQuestion(Question question) {
  var url = "https://esof.000webhostapp.com/deleteQuestion.php";
  http.post(url,
      body: {"username": question.user, "question" : question.text, "session" : question.session.toString()});
}

/* Updates the likes associated with a question as well as adds a tuple to the UserLikesQuestion table. */
void incrementLikes(Question question, String username) {
  var url = "https://esof.000webhostapp.com/addUserLikesQuestion.php";
  http.post(url,
      body: {"user": username, "question" : question.text, "session" : question.session.toString(), "userPoster": question.user });
}

/* Updates the likes associated with a question as well as removes the matching tuple from the UserLikesQuestion table. */
void decrementLikes(Question question, String username) {
  var url = "https://esof.000webhostapp.com/deleteUserLikesQuestion.php";
  http.post(url,
      body: {"user": username, "question" : question.text, "session" : question.session.toString(), "userPoster": question.user });
}