import 'package:flutter/material.dart';
import '/apiModels/my_api.dart';
import 'add_paymentMethodPage.dart';
import 'loginPage.dart';

class History extends StatelessWidget {
  final String username;
  History(this.username);
  final DatabaseHelper _databaseHelper = DatabaseHelper();
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
      body: ListView(padding: EdgeInsets.all(15), children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                'H',
                style: TextStyle(color: Colors.pink, fontSize: 50),
              ),
              Text(
                'istory',
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
            ],
          ),
        ),
        FutureBuilder<dynamic>(
          future: _databaseHelper.getMyDonations(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new DonationHistoryClass(list: snapshot.data)
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ]),
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

class DonationHistoryClass extends StatelessWidget {
  final list;
  DonationHistoryClass({required this.list});
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
              title: Text('ID: ${list[i]['student']}'),
              subtitle: Text(
                  'Semester : ${list[i]['student_semester']}\nAmount: ${list[i]['donation_amount']}'),
              trailing: Text('${(list[i]['donation_time']).substring(0, 10)}' +
                  '  ${(list[i]['donation_time']).substring(11, 16)}'),
              isThreeLine: true,
            ),
          );
        });
  }
}
