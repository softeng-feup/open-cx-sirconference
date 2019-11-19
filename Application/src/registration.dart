import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/* Struct containing the registration info of a user. */
class SignUpRequest {
  final username;
  final password;
  const SignUpRequest(this.username, this.password);
}

/* Adds an user to the database after encrypting the password. */
void addUser(SignUpRequest req) {
  print(req.username);
  var bytes = utf8.encode(req.password);
  String cryptPassword = sha256.convert(bytes).toString();
  print(cryptPassword);
  var url = "https://esof.000webhostapp.com/addUser.php";
  http.post(url,
      body: {"username": req.username, "password" : cryptPassword});
}

/* Checks if a username already exists in the database */
Future<bool> checkIfUsernameExists(String username) async {
  var url = "https://esof.000webhostapp.com/getPassword.php?username=" + username;
  http.Response response = await http.get(url);
  String data = json.decode(response.body).toString();
  if (data == 'null') // condition under which a non-existent username was input
    return false;
  return true;
}