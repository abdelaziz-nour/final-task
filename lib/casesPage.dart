import 'package:flutter/material.dart';
import '/DonatePage.dart';
import '/add_paymentMethodPage.dart';
import '/apiModels/my_api.dart';
import '/donationsHistoryPage.dart';
import 'loginPage.dart';

class Cases extends StatelessWidget {
  final String username;
  Cases(this.username);
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
                    ? new CasesClass(snapshot.data, username)
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
                  username,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ))),
            ListTile(
              title: const Text('History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History(username)),
                );
              },
            ),
            ListTile(
                title: const Text('Add Payment Method '),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPayment(username)),
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

class CasesClass extends StatelessWidget {
  final list;
  final String username1;
  CasesClass(this.list, this.username1);
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
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.pink),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Donate(username1, list, i)),
                  );
                },
                child: Text(
                  'Donate',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              isThreeLine: true,
            ),
          );
        });
  }
}
