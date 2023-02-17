import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/model/contact.dart';
import 'package:project/model/user.dart';

class FirestoreService {
  final CollectionReference contactollection =
      FirebaseFirestore.instance.collection('contacts');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addContactData(
      {String username,
      String id,
      String topic,
      String docUsername,
      String docId,
      String description}) async {
    var docRef = FirestoreService().contactollection.doc();
    print('add docRef: ' + docRef.id);

    await contactollection.doc(docRef.id).set({
      'uid': docRef.id,
      'id': id,
      'topic': topic,
      'username': username,
      'docUsername': docUsername,
      'docId': docId,
      'description': description,
    });
  }

  Future<List<Contact>> readContactData(uid) async {
    List<Contact> contactList = [];
    QuerySnapshot snapshot = await contactollection.get();

    snapshot.docs.forEach((document) {
      Contact contact = Contact.fromMap(document.data());
      if (contact.uid == uid || contact.id == uid) {
        contactList.add(contact);
      } else if (uid == 'Admin') {
        contactList.add(contact);
      }
    });

    print('Booklist: $contactList');
    return contactList;
  }

  Future<void> deleteContactData(String docId) async {
    contactollection.doc(docId).delete();

    print('deleting uid: ' + docId);
  }

  Future<void> updateContactData(
      String username, String docUsername, String description) async {
    var docRef = FirestoreService().contactollection.doc();
    print('update docRef: ' + docRef.id);

    await contactollection.doc(docRef.id).update({
      'uid': docRef.id,
      'username': username,
      'docUsername': docUsername,
      'description': description,
    });
  }

  Future<void> deleteContactDoc() async {
    await contactollection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future<void> registerUserData(String uid, String username, String address,
      String email, String role) async {
    var docRef = FirestoreService().userCollection.doc();
    print('add docRef: ' + docRef.id);

    await userCollection.doc(docRef.id).set({
      'uid': docRef.id,
      'id': uid,
      'username': username,
      'address': address,
      'email': email,
      'role': role,
      'deleted': '0',
    });
  }

  Future<List<User>> readUsersData() async {
    List<User> userList = [];
    QuerySnapshot snapshot = await userCollection.get();

    snapshot.docs.forEach((document) {
      User user = User.fromMap(document.data());
      if (user.role != 'Admin') {
        userList.add(user);
      }
    });

    print('UserList: $userList');
    return userList;
  }

  Future<List<String>> getDocUN() async {
    List<String> docList = ['None Selected'];
    QuerySnapshot snapshot = await userCollection.get();

    snapshot.docs.forEach((document) {
      User user = User.fromMap(document.data());
      if ((user.role == 'Doctor') && user.deleted != "1") {
        docList.add(user.username);
      }
    });

    print('DocList: $docList');
    return docList;
  }

  Future<User> getUsersDetails(var uid) async {
    User userinfo;
    QuerySnapshot snapshot = await userCollection.get();

    snapshot.docs.forEach((document) {
      User user = User.fromMap(document.data());
      if (user.id == uid || user.uid == uid) {
        userinfo = user;
      }
    });
    return userinfo;
  }

  Future<User> getDocsDetailsByUN(var username) async {
    User userinfo;
    QuerySnapshot snapshot = await userCollection.get();

    snapshot.docs.forEach((document) {
      User user = User.fromMap(document.data());
      if (user.username == username) {
        userinfo = user;
      }
    });
    return userinfo;
  }

  Future<bool> checkUsersRole(var uid) async {
    var admin = false;
    QuerySnapshot snapshot = await userCollection.get();

    snapshot.docs.forEach((document) {
      User user = User.fromMap(document.data());
      if (user.id == uid && (user.role == 'admin' || user.role == 'Admin')) {
        admin = true;
      }
    });
    return admin;
  }

  Future<bool> checkDocsRole(var uid) async {
    var doc = false;
    QuerySnapshot snapshot = await userCollection.get();

    snapshot.docs.forEach((document) {
      User user = User.fromMap(document.data());
      if (user.id == uid && (user.role == 'Doctor')) {
        doc = true;
      }
    });
    return doc;
  }

  Future<bool> checkUserDeleted(var uid) async {
    var deleted = false;
    QuerySnapshot snapshot = await userCollection.get();

    snapshot.docs.forEach((document) {
      User user = User.fromMap(document.data());
      if (user.id == uid && user.deleted == "1") {
        print(user.id + '+' + user.deleted.toString());
        deleted = true;
      }
    });
    return deleted;
  }

  Future<void> updatePatientData(
      {String username, String address, User userinfo}) async {
    print('updating uid: ${userinfo.uid}');

    userCollection.doc(userinfo.uid).update({
      'uid': userinfo.uid,
      'id': userinfo.id,
      'role': userinfo.role,
      'email': userinfo.email,
      'deleted': userinfo.deleted,
      'username': username,
      'address': address,
    });
  }

  Future<void> updateUserData(
      {String uid,
      String username,
      String address,
      String role,
      String deleted,
      User userinfo}) async {
    print('updating uid: ' + uid);

    userCollection.doc(uid).update({
      'uid': uid,
      'address': address,
      'username': username,
      'role': role,
      'deleted': deleted,
    });
  }

  Future<void> deleteUserData(
      String uid, String id, String email, String role) async {
    print('deleting uid: ' + uid);

    userCollection.doc(uid).update({
      'uid': uid,
      'id': id,
      'email': email,
      'role': role,
      'deleted': '1',
    });
  }
}
