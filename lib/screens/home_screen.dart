import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_text_2/api/apis.dart'; // Make sure this path is correct
import 'package:we_text_2/main.dart';
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
  //for storing all users
  List<ChatUser> _list = [];
  //for storing search items
  final List<ChatUser> _searchList = [];
  //for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  Color hexToColor(String hexCode) {
    return Color(int.parse(hexCode.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: hexToColor('#293d3d'),
      appBar: AppBar(
        centerTitle: false,
        title: _isSearching ? TextField(
          style: TextStyle(color: Colors.white,fontSize: 17,letterSpacing: 0.8),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: ("Name, email,...."),
            hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: 15),
            hintMaxLines: 1
          ),
          autofocus: true,

          onChanged: (val){
            //search Logic part
            _searchList.clear();
            for(var i in _list){
              if(i.name.toLowerCase().contains(val.toLowerCase()) ||
                  i.email.toLowerCase().contains(val.toLowerCase())){
                _searchList.add(i);
              }
            }

            setState(() {
              _searchList;
            });
          },

        ) : Text('WeText'),
        leading: Icon(Icons.home, size: 28, color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            icon: Icon(_isSearching ? CupertinoIcons.clear_circled_solid : Icons.search, size: 22),
            color: Colors.white,
          ),

          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen(user: APIs.me,)));
            },
            icon: Icon(CupertinoIcons.person, size: 22),
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
        stream: APIs.getAllUsers(),
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

              _list = data?.map((e)=>ChatUser.fromJson(e.data())).toList() ?? [];

              if(_list.isNotEmpty){
                return ListView.builder(
                  padding: EdgeInsets.only(top: 4, bottom: 50),
                  itemCount: _isSearching ? _searchList.length : _list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(user__: _isSearching ? _searchList[index] : _list[index],);
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
