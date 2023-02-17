import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/Admin/newadminhome_page.dart';
import 'package:project/screens/Doctor/newdochome_page.dart';
import 'package:project/services/firebaseauth_service.dart';
import 'package:project/screens/Patient/newhome_page.dart';
import 'package:project/screens/deleted_home_page.dart';
import 'package:project/services/firestore_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool register = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Hospital 730'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.local_hospital_rounded,
                size: 150.0,
                color: Colors.red,
              ),
              register
                  ? Column(
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText: "Username",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              labelText: "Address",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                          ),
                        ),
                      ],
                    ),
              ElevatedButton(
                onPressed: () async {
                  if (register) {
                    var newuser = await FirebaseAuthService().signUp(
                      username: usernameController.text.trim(),
                      address: addressController.text.trim(),
                      email: emailController.text.trim(),
                      role: 'Patient',
                      password: passwordController.text.trim(),
                    );
                    if (newuser != null) {
                      var user =
                          await FirestoreService().getUsersDetails(newuser.uid);
                      List<String> docList =
                          await FirestoreService().getDocUN();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => NewHomePage(
                                uid: newuser.uid,
                                username: user.username,
                                docList: docList,
                              )));
                    } else {
                      print('cant register');
                    }
                  } else {
                    User reguser = await FirebaseAuthService().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    if (reguser != null) {
                      if (await FirestoreService()
                              .checkUsersRole(reguser.uid) ==
                          true) {
                        print('Admin');
                        var user = await FirestoreService()
                            .getUsersDetails(reguser.uid);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => NewAdminHomePage(
                                  uid: reguser.uid,
                                  username: user.username,
                                )));
                      } else {
                        print('Not Admin');
                        if (await FirestoreService()
                                .checkUserDeleted(reguser.uid) !=
                            true) {
                          print('Not Deleted');
                          print(reguser.uid);
                          if (await FirestoreService()
                                  .checkDocsRole(reguser.uid) ==
                              true) {
                            print('Doctor');
                            var user = await FirestoreService()
                                .getUsersDetails(reguser.uid);
                            List<String> patList =
                                await FirestoreService().getPatUN();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => NewDocHomePage(
                                          uid: reguser.uid,
                                          username: user.username,
                                          patList: patList,
                                        )));
                          } else {
                            var user = await FirestoreService()
                                .getUsersDetails(reguser.uid);
                            List<String> docList =
                                await FirestoreService().getDocUN();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => NewHomePage(
                                          uid: reguser.uid,
                                          username: user.username,
                                          docList: docList,
                                        )));
                          }
                        } else {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => DeletedHomePage()));
                        }
                      }
                    } else {
                      print('not user');
                    }
                  }
                },
                child: register ? Text("Register") : Text("Login"),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    register = !register;
                  });
                },
                child: register
                    ? Text("Have an account? Login")
                    : Text("Create an account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
