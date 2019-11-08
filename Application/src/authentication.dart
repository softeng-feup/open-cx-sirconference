import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/* Struct containing the info about a log in request. */
class LogInRequest {
  final username;
  final password;
  const LogInRequest(this.username, this.password);
}

/* Retrieves the password of an user from the database, assigning it to the global variable 'data'. */
Future<String> getUserData(String username) async {
  var url = "https://esof.000webhostapp.com/getPassword.php?username=" + username;
  http.Response response = await http.get(url);
  String data = json.decode(response.body).toString();
  if (data == 'null') // condition under which a non-existent username was input
    return data;
  return data.substring(11, data.length - 1);
}

/* Processes a log in request. Returns true if successfully logged in and false otherwise. */
Future<bool> processLogInRequest(LogInRequest req) async {
  var bytes = utf8.encode(req.password);
  String cryptPassword = sha256.convert(bytes).toString();
  var matchPassword; // variable that will store the user's password, once retrieved from DB
  matchPassword = await getUserData(req.username); // waits for the password to be retrieved from DB
  if (matchPassword == 'null') // non-existent account, so log in fails
    return false;
  matchPassword = matchPassword.toString();
  if (cryptPassword == matchPassword)
    return true;
  return false;
}