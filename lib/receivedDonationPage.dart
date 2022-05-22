import 'package:final_task/loginPage.dart';
import 'package:flutter/material.dart';
import '/apiModels/my_api.dart';

class ReceivedDonations extends StatelessWidget {
  final String username;
  final int id;

  ReceivedDonations(this.username, this.id);
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
              );
            },
          ),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  'R',
                  style: TextStyle(color: Colors.pink, fontSize: 30),
                ),
                Text(
                  'eceived Donations',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ],
            ),
          ),
          FutureBuilder<dynamic>(
            future: _databaseHelper.getStudentDonations(id),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? snapshot.data == null
                      ? Center(
                          child: Text('No Donations yet'),
                        )
                      : CasesClass(snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ]));
  }
}

class CasesClass extends StatelessWidget {
  final list;
  CasesClass(this.list);
  @override
  Widget build(BuildContext context) {
    Map map = list.asMap();

    return ListView(
      shrinkWrap: true,
      children: [
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: list == null ? 0 : 1,
            itemBuilder: (context, index) {
              return Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: MediaQuery.of(context).size.width / 6,
                    columns: [
                      DataColumn(
                        label: Text(
                          'No',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Amount',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Time',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                    rows: map.entries
                        .map(
                          (entry) => DataRow(
                            cells: [
                              DataCell(Text(((entry.key).toString()))),
                              DataCell(Text(
                                  (entry.value['donation_amount']).toString())),
                              DataCell(Text(((entry.value['donation_time'])
                                  .toString()
                                  .substring(0, 10)))),
                              DataCell(Text(((entry.value['donation_time'])
                                  .toString()
                                  .substring(11, 16)))),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            }),
        Column(
          children: [
            Center(
              child: list[0]['donation_amount'] == 0
                  ? Text(
                      'No Donations received yet.',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.pink,
                      ),
                    )
                  : Text(
                      'Total Donations received are : ${list.length}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.pink,
                      ),
                    ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: list[0]['donation_amount'] == 0
                  ? Text(
                      'Education dues : ${list[0]['Change']}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.pink,
                      ),
                    )
                  : Text(
                      'Change :${list[0]['Change']}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.pink,
                      ),
                    ),
            ),
          ],
        )
      ],
    );
  }
}
