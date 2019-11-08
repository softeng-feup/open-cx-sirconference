import 'dart:convert';
import 'package:http/http.dart' as http;

class Question {
  final user;
  final text;
  final likesCount;
  const Question(this.user, this.text, this.likesCount);
}

Future<Question> retrieveQuestions() async {
  var url = "https://esof.000webhostapp.com/getQuestions.php";
  http.Response response = await http.get(url);
  String data = json.decode(response.body).toString();
  List<String> questionsArray = splitData(data);
  print("here:" + questionsArray.first);
  //return data.substring(11, data.length - 1);
}

List<String> splitData(String data) {
  List<String> result = [];
  while(true) {
    int startIndex = data.indexOf('{');
    if (startIndex == -1)
      break;
    int endIndex = data.indexOf('}');
    result.add(data.substring(startIndex, endIndex));
    data.replaceFirst('{', '0');
    data.replaceFirst('}', '0');
  }
  return result;
}