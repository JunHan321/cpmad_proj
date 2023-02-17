import 'package:flutter/material.dart';
import 'package:project/screens/Doctor/docaddrecord_page.dart';
import 'package:project/services/firebaseauth_service.dart';
import 'package:project/screens/Patient/home_page.dart';
import 'package:project/screens/Patient/profile.dart';
import 'package:project/screens/addrecord_page.dart';
import 'package:project/screens/showcontactrecord_page.dart';

class NewDocHomePage extends StatefulWidget {
  final uid;
  final username;
  final patList;
  final index;

  NewDocHomePage({Key key, this.uid, this.username, this.patList, this.index})
      : super(key: key);

  @override
  State<NewDocHomePage> createState() => _NewDocHomePageState();
}

class _NewDocHomePageState extends State<NewDocHomePage> {
  int _currentIndex = 0;
  List<Widget> _listPages = List();

  @override
  void initState() {
    super.initState();

    _listPages
      ..add(HomePage(username: widget.username))
      ..add(DocAddRecordPage(
        patList: widget.patList,
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
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              tooltip: 'HOME',
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box),
              tooltip: 'CONTACT FORM',
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.list),
              tooltip: 'CONTACT LIST',
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            // IconButton(
            //   icon: Icon(Icons.person),
            //   color: Colors.white,
            //   onPressed: () {
            //     setState(() {
            //       _currentIndex = 3;
            //     });
            //   },
            // ),
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
