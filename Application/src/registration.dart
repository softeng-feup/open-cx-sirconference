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