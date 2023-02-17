import 'package:flutter/material.dart';
import 'package:project/screens/Doctor/newdochome_page.dart';

class DocHomePage extends StatefulWidget {
  final username;
  DocHomePage({Key key, this.username}) : super(key: key);
  @override
  State<DocHomePage> createState() => _DocHomePageState();
}

class _DocHomePageState extends State<DocHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              IconButton(
                icon: Icon(Icons.add_box),
                iconSize: 60,
                tooltip: 'add record',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewDocHomePage(
                            index: 1,
                          )));
                },
              ),
              IconButton(
                icon: Icon(Icons.list),
                iconSize: 60,
                tooltip: 'view records',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewDocHomePage(
                            index: 2,
                          )));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
