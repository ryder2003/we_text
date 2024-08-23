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