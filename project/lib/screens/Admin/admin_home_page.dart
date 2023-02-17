import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  final uid;
  final username;
  AdminHomePage({Key key, this.uid, this.username}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "WELCOME ${widget.username}",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // IconButton(
              //   icon: Icon(Icons.add_box),
              //   iconSize: 60,
              //   tooltip: 'add record',
              //   onPressed: () {
              //     Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => AddRecordPage()));
              //   },
              // ),
              // IconButton(
              //   icon: Icon(Icons.list),
              //   iconSize: 60,
              //   tooltip: 'view records',
              //   onPressed: () {
              //     Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => RecordsPage()));
              //   },
              // )
            ],
          ),
        ],
      ),
    );
  }
}
