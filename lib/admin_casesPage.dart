import 'package:flutter/material.dart';
import '/add_casePage.dart';
import '/apiModels/my_api.dart';
import '/monthlyReportPage.dart';
import 'loginPage.dart';

class AdminCases extends StatelessWidget {
  final String username;
  AdminCases(this.username);
  @override
  Widget build(BuildContext context) {
    DatabaseHelper _databaseHelper = DatabaseHelper();
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
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  'C',
                  style: TextStyle(fontSize: 30, color: Colors.pink),
                ),
                Text(
                  'ases',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder<dynamic>(
              future: _databaseHelper.getStudents(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? new AdminCasesClass(snapshot.data, 'Admin')
                    : new Center(
                        child: new CircularProgressIndicator(),
                      );
              },
            ),
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
                  MaterialPageRoute(builder: (context) => AddCase('Admin')),
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

class AdminCasesClass extends StatelessWidget {
  final list;
  final String username1;
  AdminCasesClass(this.list, this.username1);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.pink, width: 1),
                borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 50,
                color: Colors.pink,
              ),
              title: Text('ID: ${list[i]['id']}'),
              subtitle: Text(
                  'Semester : ${list[i]['student_semester']}\nAmount: ${list[i]['student_education_dues']}'),
              isThreeLine: true,
            ),
          );
        });
  }
}
