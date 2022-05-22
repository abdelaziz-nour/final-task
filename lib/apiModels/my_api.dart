import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  var status;
  var loginEmailStatus, loginEmailStatus1, loginUsernameStatus;
  var token ='9d5296f34cfc90a9b4f4b0f9d7d0cbf5c993e1ec';

  loginData(String username, String password) async {
    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'login/',
    );
    final response = await http
        .post(myUrl, body: {"username": "$username", "password": "$password"});
    status = response.body.contains('Incorrect username or password');

    var data = json.decode(response.body);

    if (status) {
      print(data);
    } else {
      print(data);
      _save(data);
    }
  }

  registerData(String username, String email, String password, String fName,
      String lName) async {
    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'register/',
    );
    final response = await http.post(myUrl, body: {
      "username": "$username",
      "email": email,
      "password": "$password",
      "first_name": "$fName",
      "last_name": "$lName"
    });
    status = response.body.contains('error');
    loginEmailStatus1 =
        response.body.contains('A user with that Email already exists.');
    loginEmailStatus = response.body.contains('Enter a valid email address');
    loginUsernameStatus =
        response.body.contains('A user with that username already exists');

    var data = response.body;

    if (status) {
      print(data);
    } else {
      print(data);
      _save(data);
    }
  }

  Future<List> getStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final key = token;
    //final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'viewsets/student',
    );
    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'token $token'
    });
    return json.decode(response.body);
  }

  Future<List> getAllDonations() async {
    final prefs = await SharedPreferences.getInstance();
    final key = token;
    final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'donations/',
    );
    http.Response response =
        await http.get(myUrl, headers: {'Authorization': 'token $token'});
    return json.decode(response.body);
  }

  Future<List> getMyDonations() async {
    final prefs = await SharedPreferences.getInstance();
    final key = token;
    final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'mydonations/',
    );
    http.Response response =
        await http.get(myUrl, headers: {'Authorization': 'token $token'});
    return json.decode(response.body);
  }

  Future<List> getStudentDonations(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = token;
    final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'recieved/',
    );
    http.Response response = await http.post(myUrl, body: {
      "id": "$id",
    }, headers: {
      'Authorization': 'token $token'
    });
    return json.decode(response.body);
  }

  Future<List> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final key = token;
    final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'info/',
    );
    http.Response response =
        await http.get(myUrl, headers: {'Authorization': 'token $token'});
    return json.decode(response.body);
  }

  addStudent(int semester, int amount, String details) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'viewsets/student/',
    );
    final response = http.post(myUrl, headers: {
      'Authorization': 'token $token'
    }, body: {
      "student_semester": "$semester",
      "student_education_dues": "$amount",
      "student_details": "$details"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
    status = response.toString().contains('error');
  }

  donate(int id, int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final key = token;
    final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri(
      scheme: 'http',
      host: 'vzzoz.pythonanywhere.com',
      path: 'donations/',
    );
    final response = http.post(myUrl, headers: {
      'Authorization': 'token $token'
    }, body: {
      "studentID": "$id",
      "donation_amout": "$amount",
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
    status = response.toString().contains('error');
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = token;
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = token;
    final value = prefs.get(key) ?? 0;
    print('read : $token');
  }

  void showMyDialog(
      {required context,
      required String title,
      required String content,
      var page}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.pink),
                    child: new Text(
                      'Close',
                    ),
                    onPressed: () {
                      if (title == 'Failed') {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => page,
                          ),
                        );
                      }
                    })
              ]);
        });
  }
}
