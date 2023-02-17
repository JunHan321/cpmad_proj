import 'package:flutter/material.dart';
import 'package:project/screens/Admin/admin_home_page.dart';
import 'package:project/screens/Admin/showaccounts_page.dart';
import 'package:project/services/firebaseauth_service.dart';
import 'package:project/screens/Admin/register.dart';
import 'package:project/screens/addrecord_page.dart';
import 'package:project/screens/showcontactrecord_page.dart';

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
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              tooltip: 'ACCOUNTS',
              icon: Icon(Icons.people_alt),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              tooltip: 'REGISTER',
              icon: Icon(Icons.person_add),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              tooltip: 'CONTACT RECORDS',
              icon: Icon(Icons.list),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
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
