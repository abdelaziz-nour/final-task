import 'package:flutter/material.dart';
import '/apiModels/my_api.dart';
import '/casesPage.dart';
import '/loginPage.dart';
import 'donationsHistoryPage.dart';

class AddPayment extends StatelessWidget {
  final String username;
   AddPayment(this.username);
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
                        style: TextStyle(color: Colors.pink, fontSize: 30),
                      ),
                      Text(
                        'dd Payment Method',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 70,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 70,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Card number"),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 70,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Expire Date"),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.height / 3,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink),
                      ),
                      child: Text('save'),
                      onPressed: () {
                        DatabaseHelper _databaseHelper = DatabaseHelper();
                        _databaseHelper.showMyDialog(
                            context: context,
                            title: 'Failed',
                            content: 'This feautre is not available yet.');
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
                  username,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ))),
            ListTile(
              title: const Text('Cases'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cases(username)),
                );
              },
            ),
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
