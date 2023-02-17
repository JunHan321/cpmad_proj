import 'package:flutter/material.dart';
import 'package:project/screens/showreplyrecord_page.dart';
import 'package:project/services/firebaseauth_service.dart';
import 'package:project/screens/Patient/home_page.dart';
import 'package:project/screens/Patient/profile.dart';
import 'package:project/screens/addrecord_page.dart';
import 'package:project/screens/showcontactrecord_page.dart';

class NewHomePage extends StatefulWidget {
  final uid;
  final username;
  final docList;
  final index;

  NewHomePage({Key key, this.uid, this.username, this.docList, this.index})
      : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  int _currentIndex = 0;
  List<Widget> _listPages = [];

  @override
  void initState() {
    super.initState();

    _listPages
      ..add(HomePage(username: widget.username))
      ..add(AddRecordPage(
        docList: widget.docList,
        username: widget.username,
        uid: widget.uid,
      ))
      ..add(RecordsPage(
        uid: widget.uid,
      ))
      ..add(ReplyRecordsPage(
        uid: widget.uid,
      ))
      ..add(ProfilePage(uid: widget.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _listPages[widget.index == null
            ? _currentIndex
            : _currentIndex = widget.index],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              tooltip: 'HOME',
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              tooltip: 'CONTACT FORM',
              icon: Icon(Icons.add_box),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              tooltip: 'CONTACT LIST',
              icon: Icon(Icons.message),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              tooltip: 'REPLY LIST',
              icon: Icon(Icons.reply),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
            IconButton(
              tooltip: 'PROFILE',
              icon: Icon(Icons.person),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
            ),
            IconButton(
              tooltip: 'EXIT',
              onPressed: () async {
                await FirebaseAuthService().signOut();
                Navigator.of(context).pushNamed('/login');
              },
              color: Colors.white,
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
