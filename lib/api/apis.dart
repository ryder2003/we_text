import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_text_2/models/chat_user.dart';

class APIs{
  //For authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore databse
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //for accessing cloud firebase Storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //For storing self information
  static late ChatUser me;

  //To return current user
  static User get _user =>auth.currentUser!;

  //FOR checking user exists or not
  static Future<bool> userExists() async{
    return (await firestore.collection('users').doc(auth.currentUser!.uid).get()).exists; //exclamation mark to ensure here that current user is not null
  }

  //For getting info of current user
  static Future<void> getSelfInfo() async{
    await firestore.collection('users').doc(_user.uid).get().then((_user) async{
      if(_user.exists){
        me = ChatUser.fromJson(_user.data()!);
        print("My data: ${_user.data()}");
      }
      else{
        await createUser().then((value)=>getSelfInfo());
      }
    });
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

  //For getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(){
    return firestore.collection('users').where('id',isNotEqualTo: _user.uid).snapshots();
  }

  //To update user's personal info
  static Future<void> updateUSerInfo() async{
    await firestore.collection('users').doc(_user.uid).update({
      'name': me.name,
      'about': me.about
    });
  }

  //Update Profile Picture of User
  static Future<void> updateProfilePicture(File file) async{
    //Getting image final extension
    final ext = file.path.split('.').last; //This will return the string after '.'\
    print("Extension: $ext");

    //Storage final reference with path
    final ref = storage.ref().child('profile_pictures/${_user.uid}.$ext');

    //Uploading image
    await ref.putFile(file, SettableMetadata(contentType: "image/$ext")).then((p0){
      print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //Updating image in firebase database
    me.image = await ref.getDownloadURL();
    await firestore. collection('users').doc(_user.uid).update({
      'image': me.image
    });
  }

  //Apply Customised Colour
  static Color hexToColor(String hexCode){
    return Color(int.parse(hexCode.substring(1, 7),radix: 16) + 0xFF000000);
  }

  //*************Chat Screen Related APIs

  //for getting all messages of a specified conversation
  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllMessages (){
    return firestore.collection('messages').snapshots();
}


}