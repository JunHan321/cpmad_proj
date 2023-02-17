import 'package:flutter/material.dart';
import 'package:project/model/user.dart';
import 'package:project/screens/Patient/newhome_page.dart';
import 'package:project/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRecordPage extends StatefulWidget {
  final uid;
  final username;
  List<String> docList;

  AddRecordPage({Key key, this.docList, this.uid, this.username})
      : super(key: key);
  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  String topic;
  String docUsername;
  String docId;
  String description;

  String dropdownvalue = 'None Selected';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Doctor'), actions: <Widget>[]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // TextFormField(
                //   keyboardType: TextInputType.text,
                //   decoration: InputDecoration(labelText: 'Username'),
                //   validator: (val) => val.length == 0 ? "Enter Username" : null,
                //   onSaved: (val) => this.username = val,
                // ),
                Row(
                  children: [
                    Text(
                      'Doctor\'s Username: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: widget.docList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownvalue = newValue;
                          this.docUsername = newValue;
                        });
                      },
                    ),
                  ],
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Topic'),
                  validator: (val) => val.length == 0 ? 'Enter Topic' : null,
                  onSaved: (val) => this.topic = val,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (val) =>
                      val.length == 0 ? 'Enter Description' : null,
                  onSaved: (val) => this.description = val,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: this.docUsername != null ? _submit : null,
                    child: Text('Submit'),
                  ),
                )
              ],
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

    User user = await FirestoreService().getDocsDetailsByUN(this.docUsername);

    FirestoreService().addContactData(
        username: widget.username,
        id: widget.uid,
        topic: topic,
        docUsername: docUsername,
        docId: user.id,
        description: description);

    Fluttertoast.showToast(
        msg: "Data saved successfully", gravity: ToastGravity.TOP);
  }
}
