import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_text_2/models/chat_user.dart';
import 'package:we_text_2/screens/chat_screen.dart';

import '../main.dart';

class ChatUserCard extends StatefulWidget{
  final ChatUser user__;

  const ChatUserCard({super.key, required this.user__});


  @override
  State<StatefulWidget> createState()=>ChatUserCardState();
}

class ChatUserCardState extends State<ChatUserCard>{
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey,
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),

        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user__,)));
          },
          child: ListTile(
            //User Profile picture
            //leading: CircleAvatar(child: Icon(CupertinoIcons.person),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                width: mq.height * .055,
                height: mq.height * .055,
                imageUrl: widget.user__.image,
                //placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                  child: Icon(CupertinoIcons.person),
                ),
              
              ),
            ),
            //USer name
            title: Text(widget.user__.name),
            //Last message of user
            subtitle: Text(widget.user__.about, maxLines: 1),
            //last online time
            trailing: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(10)
              ),
            )
            //trailing: Text("12 PM",style: TextStyle(color: Colors.black54),),

          ),
        ),
      );
  }
}
