import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/model/user.dart';
import 'package:project/screens/Admin/newadminhome_page.dart';
import 'package:project/services/firestore_service.dart';

class EditPage extends StatefulWidget {
  final uid;
  EditPage({Key key, this.uid}) : super(key: key);
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String email;
  String username;
  String address;
  String role;
  String deleted;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Edit Account'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (val) =>
                            val.length == 0 ? "Enter Username" : null,
                        onSaved: (val) => this.username = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Role'),
                        validator: (val) =>
                            val.length == 0 ? "Enter Role" : null,
                        onSaved: (val) => this.role = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Deleted'),
                        validator: (val) =>
                            val.length == 0 ? "Enter Deleted" : null,
                        onSaved: (val) => this.deleted = val,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text("Save"),
              ),
            ],
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

    FirestoreService().updateUserData(
        uid: widget.uid,
        address: userinfo.address,
        username: this.username,
        role: this.role,
        deleted: this.deleted,
        userinfo: userinfo);

    Fluttertoast.showToast(
        msg: "Data saved successfully", gravity: ToastGravity.TOP);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewAdminHomePage(
              index: 1,
            )));
  }
}
