import 'package:flutter/material.dart';
import 'package:project/screens/Admin/newadminhome_page.dart';
import 'package:project/screens/Patient/newhome_page.dart';
import 'package:project/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      title: 'Hospital 730',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => NewHomePage(),
        '/adminhome': (context) => NewAdminHomePage(),
      },
      home: LoginPage(),
    );
  }
}
