import 'package:flutter/material.dart';
import '/loginPage.dart';
import 'admin_casesPage.dart';
import 'apiModels/my_api.dart';
import 'monthlyReportPage.dart';

class AddCase extends StatelessWidget {
  final String username;
  AddCase(this.username);
  final _addcaseformKey = GlobalKey<FormState>();
  final semsterController = TextEditingController();
  final amountController = TextEditingController();
  final detailsController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  _onPressed(context) async {
    await _databaseHelper.addStudent((int.parse(semsterController.text.trim())),
        (int.parse(amountController.text.trim())), detailsController.text);
    if (_databaseHelper.status) {
      print(_databaseHelper.status);
      _databaseHelper.showMyDialog(
        context: context,
        title: 'Failed',
        content: 'Adding student failed please try again',
      );
    } else
      print(_databaseHelper.status);
    _databaseHelper.showMyDialog(
      context: context,
      title: 'Success',
      content: 'Student added successfully.',
      page: AdminCases('Admin'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "The",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "Red",
              style: TextStyle(fontSize: 35, color: Colors.pink),
            ),
            Text("Pen", style: TextStyle(fontSize: 35)),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Row(
                    children: [
                      Text(
                        'A',
                        style: TextStyle(color: Colors.pink, fontSize: 50),
                      ),
                      Text(
                        'dd Case',
                        style: TextStyle(color: Colors.black, fontSize: 50),
                      ),
                    ],
                  ),
                  Form(
                      key: _addcaseformKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: "Semester number"),
                            controller: semsterController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter semster number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: "Education dues"),
                            controller: amountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter education dues';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                              color: Colors.white,
                              elevation: 0,
                              child: TextFormField(
                                controller: detailsController,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  labelText: 'student issues',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.pink),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.height / 3,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink),
                      ),
                      child: Text('Add'),
                      onPressed: () {
                        if (_addcaseformKey.currentState!.validate()) {
                          _onPressed(context);
                        }
                      },
                    ),
                  ),
                ])),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink,
                ),
                child: Center(
                    child: Text(
                  'Admin',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ))),
            ListTile(
              title: const Text('Add Case'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCase(username)),
                );
              },
            ),
            ListTile(
                title: const Text('Monthly Report '),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Report('Admin')),
                  );
                }),
            ListTile(
                title: const Text('Logout '),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
