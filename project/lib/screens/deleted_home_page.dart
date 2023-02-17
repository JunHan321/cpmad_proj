import 'package:flutter/material.dart';
import 'package:project/services/firebaseauth_service.dart';

class DeletedHomePage extends StatefulWidget {
  @override
  State<DeletedHomePage> createState() => _DeletedHomePageState();
}

class _DeletedHomePageState extends State<DeletedHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "YOUR ACCOUNT HAS BEEN DELETED",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        backgroundColor: Colors.blueAccent,
        tooltip: 'EXIT',
        onPressed: () async {
          await FirebaseAuthService().signOut();
          Navigator.of(context).pushNamed('/login');
        },
      ),
    );
  }
}
