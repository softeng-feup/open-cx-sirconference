import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/* Struct containing the registration info of a user. */
class SignUpRequest {
  final username;
  final password;
  final safeAnswer;
  const SignUpRequest(this.username, this.password, this.safeAnswer);
}

/* Adds an user to the database after encrypting the password. */
void addUser(SignUpRequest req) {
  var bytes = utf8.encode(req.password);
  String cryptPassword = sha256.convert(bytes).toString();
  var url = "https://esof.000webhostapp.com/addUser.php";
  http.post(url,
      body: {"username": req.username, "password" : cryptPassword, "safeAnswer": req.safeAnswer});
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

/* Changes the username of a user, changing it to 'newUsername', as long as 'newUsername' is not taken. */
void updateUsername(String username, String newUsername) {
  var url = "https://esof.000webhostapp.com/updateUsername.php";
  http.post(url,
      body: {"username": username, "newUsername": newUsername});
}

/* Changes the password of a user, assigning it as 'newPassword' after the crypt sum is calculated. */
void updatePassword(String username, String newPassword) {
  print(username);
  print(newPassword);
  var bytes = utf8.encode(newPassword);
  String cryptPassword = sha256.convert(bytes).toString();
  var url = "https://esof.000webhostapp.com/updatePassword.php";
  http.post(url,
      body: {"username": username, "newPassword" : cryptPassword});
}