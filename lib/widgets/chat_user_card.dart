import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_text_2/models/chat_user.dart';

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
          onTap: (){},
          child: ListTile(
            leading: CircleAvatar(child: Icon(CupertinoIcons.person),),
            title: Text(widget.user__.name),
            subtitle: Text(widget.user__.about, maxLines: 1),
            trailing: Text("12 PM",style: TextStyle(color: Colors.black54),),
            hoverColor: Colors.green,

          ),
        ),
      );
  }
}
