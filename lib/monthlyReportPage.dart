import 'package:flutter/material.dart';
import '/apiModels/my_api.dart';

class Report extends StatelessWidget {
  final String username;

  Report(this.username);
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
        body: ListView(shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  'M',
                  style: TextStyle(color: Colors.pink, fontSize: 30),
                ),
                Text(
                  'onthly Report',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ],
            ),
          ),
          FutureBuilder<dynamic>(
            future: _databaseHelper.getAllDonations(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new CasesClass(snapshot.data)
                  : new Center(
                      child: new CircularProgressIndicator(),
                    );
            },
          ),
        ]));
  }
}

class CasesClass extends StatelessWidget {
  var list;
  CasesClass(this.list);
  @override
  Widget build(BuildContext context) {
    Map map = list.asMap();

    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: list == null ? 0 : 1,
            itemBuilder: (context, index) {
              return Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
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
                            'Donor',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Student ID',
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
                            'Date And Time',
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
                                DataCell(Text((entry.key).toString())),
                                DataCell(Text(entry.value['donor'])),
                                DataCell(
                                    Text((entry.value['student']).toString())),
                                DataCell(Text((entry.value['donation_amount'])
                                    .toString())),
                                DataCell(Text(
                                    '${entry.value['date'].substring(0, 10)}' +
                                        '  ${entry.value['date'].substring(11, 16)}')),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              );
            }),
        Center(
          child: Text(
            'Total Donations are : ${list.length}',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.pink,
            ),
          ),
        )
      ],
    );
  }
}
