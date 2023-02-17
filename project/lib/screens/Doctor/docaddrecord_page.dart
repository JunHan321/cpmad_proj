import 'package:flutter/material.dart';
import 'package:project/model/user.dart';
import 'package:project/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DocAddRecordPage extends StatefulWidget {
  final uid;
  final username;
  List<String> patList;

  DocAddRecordPage({Key key, this.patList, this.uid, this.username})
      : super(key: key);
  @override
  State<DocAddRecordPage> createState() => _DocAddRecordPageState();
}

class _DocAddRecordPageState extends State<DocAddRecordPage> {
  String topic;
  String patUsername;
  String docId;
  String description;

  String dropdownvalue = 'None Selected';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Patient'), actions: <Widget>[]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Patient\'s Username: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: widget.patList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownvalue = newValue;
                          this.patUsername = newValue;
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
                  child: ElevatedButton(
                    onPressed: this.patUsername != null ? _submit : null,
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

    User user = await FirestoreService().getPatsDetailsByUN(this.patUsername);

    FirestoreService().addReplyData(
        username: widget.username,
        id: widget.uid,
        topic: topic,
        patUsername: patUsername,
        docId: user.id,
        description: description);

    Fluttertoast.showToast(
        msg: "Data saved successfully", gravity: ToastGravity.TOP);
  }
}
