import 'dart:convert';
import 'package:http/http.dart' as http;

class Question {
  final user;
  final text;
  final likesCount;
  const Question(this.user, this.text, this.likesCount);
}

/* Gets the questions from the database, processing the received data and returning it in the form of a list. */
Future<List<Question>> retrieveQuestions() async {
  var url = "https://esof.000webhostapp.com/getQuestions.php";
  http.Response response = await http.get(url);
  String data = json.decode(response.body).toString();
  List<String> questions = splitData(data);
  return parseQuestions(questions);
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
Question parseQuestion(String data) {
  int usernameIndex = data.indexOf('username:') + 10; // index where the username string starts
  data = data.substring(usernameIndex); // now the username starts at position 0
  usernameIndex = data.indexOf(',') - 1; // index where the username string ends
  String username = data.substring(0, usernameIndex + 1);
  int questionIndex = data.indexOf('question:') + 10; // index where the question starts
  String question = data.substring(questionIndex); // now the question starts at position 0
  return new Question(username, question, 0);
}

/* Converts a list of Strings into a list of Questions. */
List<Question> parseQuestions(List<String> data) {
  List<Question> questions = [];
  for (var element in data) {
    questions.add(parseQuestion(element));
  }
  return questions;
}

/* Inserts a question into the database. */
void addQuestion(String question) {
  var url = "https://esof.000webhostapp.com/addData.php";
  http.post(url,
      body: {"username": "UserXX", "question" : question});
}