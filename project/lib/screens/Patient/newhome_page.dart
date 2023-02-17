import 'package:flutter/material.dart';
import 'package:project/services/firebaseauth_service.dart';
import 'package:project/screens/Patient/home_page.dart';
import 'package:project/screens/Patient/profile.dart';
import 'package:project/screens/addrecord_page.dart';
import 'package:project/screens/showrecord_page.dart';

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
  List<Widget> _listPages = List();

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
        color: Colors.blueAccent,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.list),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
            IconButton(
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.logout),
      //   backgroundColor: Colors.blueAccent,
      //   tooltip: 'Sign Out',
      //   onPressed: () async {
      //     await FirebaseAuthService().signOut();
      //     Navigator.of(context).pushNamed('/login');
      //   },
      // ),
    );
  }
}
