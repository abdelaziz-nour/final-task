import 'package:final_task/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/admin_casesPage.dart';
import '/apiModels/my_api.dart';
import '/casesPage.dart';
import '/receivedDonationPage.dart';
import '/registerPage.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);

  final _LoginformKey = GlobalKey<FormState>();
  final _formkeySudent = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  static bool checker = false;

  void _showDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text('Failed'),
              content: new Text('Incorrect email or password.'),
              actions: <Widget>[
                new ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.pink),
                    child: new Text(
                      'Close',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  _onPressed(context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print(emailController.text);
    print(passwordController.text);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Cases(emailController.text)),
      );
    } catch (e) {
      _databaseHelper.showMyDialog(
          context: context,
          title: 'Failed',
          content: 'Incorrect email or paswword');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('lib/logo.jpeg'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "The",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 15),
                ),
                Text(
                  "Red",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 15,
                      color: Colors.pink),
                ),
                Text(
                  "Pen",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 15),
                ),
              ],
            ),
            Form(
                key: _LoginformKey,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Enter valid Email '),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter secure password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You Don\'t have an account ? ',
                            style: TextStyle(fontSize: 18),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()),
                                );
                              },
                              child: Text(
                                'Register',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.pink),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.height / 3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: Text('Login'),
                        onPressed: () {
                          if (_LoginformKey.currentState!.validate()) {
                            _onPressed(context);
                          }
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminCases('Admin')),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          'Admin',
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Student',
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  title: Text('Enter Student ID'),
                                  content: Form(
                                      key: _formkeySudent,
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              controller: idController,
                                              maxLength: 6,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'ID',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter  Student ID';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  15,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.pink),
                                                  ),
                                                  child: Text('Enter'),
                                                  onPressed: () async {
                                                    if (_formkeySudent
                                                        .currentState!
                                                        .validate()) {
                                                      List students =
                                                          await _databaseHelper
                                                              .getStudents();
                                                      for (var map
                                                          in students) {
                                                        if (map["id"] ==
                                                            int.parse(
                                                                idController
                                                                    .text
                                                                    .trim())) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ReceivedDonations(
                                                                          'Student',
                                                                          int.parse(idController
                                                                              .text
                                                                              .trim()),
                                                                        )),
                                                          );
                                                          checker = true;
                                                          break;
                                                        }
                                                      }
                                                      if (checker == false) {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                  title: new Text(
                                                                      'Failed'),
                                                                  content: new Text(
                                                                      'Invalid student ID'),
                                                                  actions: <
                                                                      Widget>[
                                                                    new ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: Colors
                                                                                .pink),
                                                                        child:
                                                                            new Text(
                                                                          'Close',
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => Welcome()),
                                                                          );
                                                                        })
                                                                  ]);
                                                            });
                                                      }
                                                      checker = false;
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                      )),
                                  actions: <Widget>[
                                    new ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.pink),
                                        child: new Text(
                                          'Close',
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        })
                                  ]);
                            });
                      },
                    )
                  ],
                )),
          ],
        ),
      ],
    ));
  }
}
