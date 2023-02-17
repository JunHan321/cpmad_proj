import 'package:flutter/material.dart';
import 'package:project/model/user.dart';
import 'package:project/screens/Patient/newhome_page.dart';
import 'package:project/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  final uid;
  ProfilePage({Key key, this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username;
  String address;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // TextFormField(
                  //   keyboardType: TextInputType.text,
                  //   decoration: InputDecoration(labelText: 'Username'),
                  //   validator: (val) =>
                  //       val.length == 0 ? "Enter Username" : null,
                  //   onSaved: (val) => this.username = val,
                  // ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (val) =>
                        val.length == 0 ? 'Enter Address' : null,
                    onSaved: (val) => this.address = val,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      onPressed: _submit,
                      child: Text('Save'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return null;
    }
    User userinfo = await FirestoreService().getUsersDetails(widget.uid);

    FirestoreService().updatePatientData(
        username: userinfo.username, address: this.address, userinfo: userinfo);

    Fluttertoast.showToast(
        msg: "Data saved successfully", gravity: ToastGravity.TOP);

    List<String> docList = await FirestoreService().getDocUN();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => NewHomePage(
              uid: userinfo.id,
              username: userinfo.username,
              docList: docList,
            )));
  }
}
