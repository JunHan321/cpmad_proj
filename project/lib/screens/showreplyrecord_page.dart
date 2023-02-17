import 'package:flutter/material.dart';
import 'package:project/model/contact.dart';
import 'package:project/model/reply.dart';
import 'package:project/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReplyRecordsPage extends StatefulWidget {
  final uid;
  ReplyRecordsPage({Key key, this.uid}) : super(key: key);
  @override
  State<ReplyRecordsPage> createState() => _ReplyRecordsPageState();
}

class _ReplyRecordsPageState extends State<ReplyRecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replies Records'),
      ),
      body: FutureBuilder<List<Reply>>(
        future: FirestoreService().readReplyData(widget.uid),
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
                        children: [
                          Text(
                            "From: ${snapshot.data[index].username}",
                            style:
                                TextStyle(color: Colors.teal, fontSize: 16.0),
                          ),
                          Text(
                            "To: ${snapshot.data[index].patUsername}",
                            style:
                                TextStyle(color: Colors.teal, fontSize: 16.0),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            snapshot.data[index].topic,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                          Text(
                            snapshot.data[index].description,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                          ),
                        ],
                      ),
                      IconButton(
                        color: Colors.teal,
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          setState(() {
                            FirestoreService()
                                .deleteContactData(snapshot.data[index].uid);
                          });
                          Fluttertoast.showToast(
                              msg: "Data deleted successfully",
                              gravity: ToastGravity.TOP);
                        },
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
