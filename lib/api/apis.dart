import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_text_2/models/chat_user.dart';

class APIs{
  //For authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore databse
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //To return current user
  static User get _user =>auth.currentUser!;

  //FOR checking user exists or not
  static Future<bool> userExists() async{
    return (await firestore.collection('users').doc(auth.currentUser!.uid).get()).exists; //exclamation mark to ensure here that current user is not null
  }

  //For creating new user
  static Future<void> createUser() async{
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final userChat = ChatUser(
      id: _user.uid,
      name: _user.displayName.toString(),
      email: _user.email.toString(),
      about: "Hey, I'm using WeText!",
      image: _user.photoURL.toString(),
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: ''
    );
    return await firestore.collection('users').doc(_user.uid).set(userChat.toJson());
  }
}