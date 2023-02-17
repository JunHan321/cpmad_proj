class Reply {
  String uid;
  String id;
  String topic;
  String username;
  String patUsername;
  String docId;
  String description;

  Reply(
      {this.uid,
      this.id,
      this.username,
      this.topic,
      this.patUsername,
      this.docId,
      this.description});

  Reply.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    id = data['id'];
    username = data['username'];
    topic = data['topic'];
    patUsername = data['patUsername'];
    docId = data['docId'];
    description = data['description'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'username': username,
      'topic': topic,
      'patUsername': patUsername,
      'docId': docId,
      'description': description
    };
  }
}
