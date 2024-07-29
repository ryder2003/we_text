import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_text_2/api/apis.dart'; // Make sure this path is correct
import 'package:we_text_2/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_text_2/models/chat_user.dart';
import 'package:we_text_2/screens/auth/login_screen.dart'; // Make sure this path is correct
import 'package:we_text_2/screens/profile_screen.dart';
import 'package:we_text_2/widgets/chat_user_card.dart'; // Make sure this path is correct
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

void main() {
  runApp(const MyApp());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomeScreenState();
  }
}

class MyHomeScreenState extends State<HomeScreen> {
  Color hexToColor(String hexCode) {
    return Color(int.parse(hexCode.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    List<ChatUser> list = [];
    return Scaffold(
      backgroundColor: hexToColor('#293d3d'),
      appBar: AppBar(
        centerTitle: false,
        title: Text('WeText'),
        leading: Icon(Icons.home, size: 30, color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 25),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen(user: list[0],)));
            },
            icon: Icon(CupertinoIcons.person, size: 25),
            color: Colors.white,
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut(); // Ensure APIs.auth is correctly initialized
            await GoogleSignIn().signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.active:
            case ConnectionState.done:

              final data = snapshot.data?.docs;

              //This will print data in json format which can be directly used to generate dart code
              // for(var i in data!){
              //   print("\nData: ${i.data()}");
              // }

              list = data?.map((e)=>ChatUser.fromJson(e.data())).toList() ?? [];

              if(list.isNotEmpty){
                return ListView.builder(
                  padding: EdgeInsets.only(top: 4, bottom: 50),
                  itemCount: list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(user__: list[index],);
                  },
                );
              }
              else{
                return Center(
                  child: Text("No Recent Chats!",style: TextStyle(
                    fontSize: 25,
                    color: Colors.white
                  ),),
                );
              }
          }
        },
      ),
    );
  }
}
