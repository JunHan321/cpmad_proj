import 'package:flutter/material.dart';
import 'package:project/screens/Admin/edit_page.dart';
import 'package:project/model/user.dart';
import 'package:project/screens/Admin/newadminhome_page.dart';
import 'package:project/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountsPage extends StatefulWidget {
  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts Details'),
      ),
      body: FutureBuilder<List<User>>(
        future: FirestoreService().readUsersData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Username: " + snapshot.data[index].username,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Email: " + snapshot.data[index].email,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                            ),
                          ]),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                snapshot.data[index].role != null
                                    ? "Role: " + snapshot.data[index].role
                                    : "Role: ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              ),
                              Text(
                                snapshot.data[index].deleted != '1'
                                    ? ""
                                    : "Deleted",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              ),
                            ],
                          ),
                          IconButton(
                            color: Colors.blue,
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditPage(uid: snapshot.data[index].uid)));
                            },
                          ),
                          IconButton(
                            color: Colors.blue,
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              setState(() {
                                FirestoreService().deleteUserData(
                                    snapshot.data[index].uid,
                                    snapshot.data[index].id,
                                    snapshot.data[index].email,
                                    snapshot.data[index].role);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NewAdminHomePage(index: 1,)));
                              });
                              Fluttertoast.showToast(
                                  msg: "Data deleted successfully",
                                  gravity: ToastGravity.TOP);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Container(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
