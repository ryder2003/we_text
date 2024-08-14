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
}