class User {
  String uid;
  String id;
  String username;
  String address;
  String role;
  String email;
  String deleted;

  User(
      {this.uid,
      this.id,
      this.username,
      this.address,
      this.role,
      this.email,
      this.deleted});

  User.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    id = data['id'];
    username = data['username'];
    address = data['address'];
    role = data['role'];
    email = data['email'];
    deleted = data['deleted'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'username': username,
      'address': address,
      'role': role,
      'email': email,
      'deleted': deleted
    };
  }
}
