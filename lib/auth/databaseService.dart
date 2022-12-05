import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  // final CollectionReference studioCollection =
  //     FirebaseFirestore.instance.collection("studioUsers");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // Future updateStudioUserData(String fullName, String email) async {
  //   return await studioCollection.doc(uid).set({
  //     "fullName": fullName,
  //     "email": email,
  //     "groups": [],
  //     "profilePic": "",
  //     "uid": uid,
  //   });
  // }

  // Future gettingStudioUserData(String email) async {
  //   QuerySnapshot snapshot =
  //       await studioCollection.where("email", isEqualTo: email).get();
  //   return snapshot;
  // }

  Future getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // Future getStudioUserGroups() async {
  //   return studioCollection.doc(uid).snapshots();
  // }

  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${uid}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });

    await groupDocumentReference.update({
      "members":
          FieldValue.arrayUnion(["${uid}_$userName", "${id}_$groupName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference user2DocumentReference = userCollection.doc(id);
    await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"]),
    });
    await user2DocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"]),
    });
    return [groupDocumentReference.id, groupName, userName];
  }

  // Future<dynamic> createStudioGroup(
  //     String userName, String id, String groupName) async {
  //   DocumentReference groupDocumentReference = await groupCollection.add({
  //     "groupName": groupName,
  //     "groupIcon": "",
  //     "admin": "${id}_$userName",
  //     "members": [],
  //     "groupId": "",
  //     "recentMessage": "",
  //     "recentMessageSender": "",
  //   });

  //   await groupDocumentReference.update({
  //     "members":
  //         FieldValue.arrayUnion(["${uid}_$userName", "${uid}_$groupName"]),
  //     "groupId": groupDocumentReference.id,
  //   });

  //   DocumentReference studioDocumentReference = studioCollection.doc(uid);
  //   await studioDocumentReference.update({
  //     "groups":
  //         FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"]),
  //   });
  //   return [groupDocumentReference.id, groupName, userName];
  // }

  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  getMembers(String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];

    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];

    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"]),
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"]),
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"]),
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      });
    }
  }
}
