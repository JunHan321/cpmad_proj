import 'package:flutter/material.dart';
import 'package:project/screens/Admin/admin_home_page.dart';
import 'package:project/screens/Admin/showaccounts_page.dart';
import 'package:project/services/firebaseauth_service.dart';
import 'package:project/screens/Admin/register.dart';
import 'package:project/screens/addrecord_page.dart';
import 'package:project/screens/showrecord_page.dart';

class NewAdminHomePage extends StatefulWidget {
  final uid;
  final username;
  final index;
  NewAdminHomePage({Key key, this.uid, this.index, this.username})
      : super(key: key);

  @override
  State<NewAdminHomePage> createState() => _NewAdminHomePageState();
}

class _NewAdminHomePageState extends State<NewAdminHomePage> {
  int _currentIndex = 0;
  List<Widget> _listPages = List();

  @override
  void initState() {
    super.initState();

    _listPages
      ..add(AdminHomePage(
        username: widget.username,
      ))
      ..add(AccountsPage())
      ..add(RegisterPage())
      ..add(AddRecordPage())
      ..add(RecordsPage(
        uid: 'Admin',
      ));
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              icon: Icon(Icons.people_alt),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person_add),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            // IconButton(
            //   icon: Icon(Icons.add_box),
            //   color: Colors.white,
            //   onPressed: () {
            //     setState(() {
            //       _currentIndex = 3;
            //     });
            //   },
            // ),
            IconButton(
              icon: Icon(Icons.list),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 4;
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
    );
  }
}
