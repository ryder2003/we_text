import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_text_2/api/apis.dart';
import 'package:we_text_2/models/chat_user.dart';

import '../main.dart';

class ChatScreen extends StatefulWidget{
  final ChatUser user;
  const ChatScreen({super.key, required this.user});
  @override
  State<StatefulWidget> createState() =>ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: APIs.hexToColor('#293d3d'),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),
        body: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: APIs.getAllMessages(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());
                
                      case ConnectionState.active:
                      case ConnectionState.done:
                
                        final data = snapshot.data?.docs;
                        print("Data: ${jsonEncode(data![0].data())}");
                
                        //This will print data in json format which can be directly used to generate dart code
                        // for(var i in data!){
                        //   print("\nData: ${i.data()}");
                        // }
                
                        //
                        final _list = [];
                
                        if(_list.isNotEmpty){
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 4, bottom: 50),
                            itemCount: _list.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Text("Message: ${_list[index]}");
                            },
                          );
                        }
                        else{
                          return Center(
                            child: Text("Say Hii! 👋",style: TextStyle(
                                fontSize: 25,
                                color: Colors.white
                            ),),
                          );
                        }
                    }
                  },
                ),
              ),
              
              _chatInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(){
    return InkWell(
      onTap: (){},
      child: Row(
        children: [
          IconButton(
              onPressed: () =>Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white,)
          ),
          //
          SizedBox(width: 1),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              width: mq.height * .045,
              height: mq.height * .045,
              imageUrl: widget.user.image,
              //placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),

            ),
          ),
          //Adding some Space
          SizedBox(width: 11,),
          //User name and last seen time
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //User name
              Text(widget.user.name, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),

              //Last seen time
              Text("Last seen not available",style: TextStyle(color: Colors.grey,fontSize: 11),)
            ],
          )
        ],
      ),
    );
  }
}

Widget _chatInput(){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: mq.height * .01, horizontal: mq.width * .025),
    child: Row(
      children: [
        //Expanded is used so that card takes maximum space availabe of parent and does not cause any overflow
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                //Emoji button
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.emoji_emotions,color: Colors.blue,size: 26,)
                ),

                //
                Expanded(
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline, //To prevent hovering long text, it will adjust according to length of text
                    decoration: InputDecoration(
                      hintText: "Type Something....",
                      hintStyle: TextStyle(color: Colors.blueAccent, fontSize: 13),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                //Pick Image from gallery button
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.image,color: Colors.blue,size: 26,)
                ),

                //Camera button
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.camera_alt,color: Colors.blue,size: 26,)
                ),
                //Adding some space
                SizedBox(width: mq.width * .02)
              ],
            ),
          ),
        ),

        //Send Button
        MaterialButton(
          onPressed: (){},
          padding: EdgeInsets.only(top: 10,bottom: 10, right: 5, left: 10),
          minWidth: 0,
          shape: CircleBorder(),
          color: Colors.green,
          child: Icon(Icons.send,color: CupertinoColors.white,size: 28,),
        )
      ],
    ),
  );
}