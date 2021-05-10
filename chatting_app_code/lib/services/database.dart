import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  getUserbyUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        // ignore: deprecated_member_use
        .getDocuments()
        .catchError((e) {
      print(e);
    });
  }

  getUserbyEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        // ignore: deprecated_member_use
        .getDocuments()
        .catchError((e) {
      print(e);
    });
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    // ignore: deprecated_member_use
    Firestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
