class Contact {
  String uid;
  String id;
  String topic;
  String username;
  String docUsername;
  String docId;
  String description;

  Contact(
      {this.uid,
      this.id,
      this.username,
      this.topic,
      this.docUsername,
      this.docId,
      this.description});

  Contact.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    id = data['id'];
    username = data['username'];
    topic = data['topic'];
    docUsername = data['docUsername'];
    docId = data['docId'];
    description = data['description'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'username': username,
      'topic': topic,
      'docUsername': docUsername,
      'docId': docId,
      'description': description
    };
  }
}
