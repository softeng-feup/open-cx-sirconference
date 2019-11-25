import 'package:http/http.dart' as http;

/* Adds a session to the database, assigning it the respective code and creator. */
createSession(String code, String username) {
  var url = "https://esof.000webhostapp.com/addSession.php";
  http.post(url,
      body: {"code": code, "name": 'defaultName', "creator": username});
}

/* Deletes a session from the database if the user deleting it is the session creator. */
deleteSession(String code, String username) {
  var url = "https://esof.000webhostapp.com/deleteSession.php";
  http.post(url,
      body: {"code": code, "creator": username});
}