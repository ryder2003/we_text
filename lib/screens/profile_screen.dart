import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_text_2/api/apis.dart';
import 'package:we_text_2/helper/dialogs.dart';
import 'package:we_text_2/models/chat_user.dart';
import 'package:we_text_2/screens/auth/login_screen.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget{
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});
  @override
  State<StatefulWidget> createState() =>ProfileScreenState() ;
}

class ProfileScreenState extends State<ProfileScreen>{
  final _formKey = GlobalKey<FormState>();

  Color hexToColor(String hexCode){
    return Color(int.parse(hexCode.substring(1,7),radix: 16) + 0xF000000);
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        //backgroundColor: Colors.grey,
       appBar: AppBar(
         title: Text("Profile Details",style: TextStyle(fontSize: 25),),
         centerTitle: false,
       ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async{
              //For showing progress bar
              Dialogs.showProgressLoader(context);
              //sign out from the app
              await APIs.auth.signOut().then((value) async{
                await GoogleSignIn().signOut().then((value){
                  //For hiding progress bar
                Navigator.pop(context);

                //For moving to home screen so nothing remains in back stack after push replacement
                Navigator.pop(context);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                });
              });
            },
            icon: Icon(Icons.logout,color: Colors.white,),
            label: Text("Logout",style: TextStyle(color: Colors.white),),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //for adding some space, we can use sized box
                  SizedBox(width: mq.width,height: mq.height * .02,),

                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          width: mq.height * .16,
                          height: mq.height * .16,
                          fit: BoxFit.fill,
                          imageUrl: widget.user.image,
                          //placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ),

                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: -5,
                        width: mq.width * .2,
                        height: mq.height * .03,
                        child: MaterialButton(
                            onPressed: (){},
                          child: Icon(Icons.edit,color: Colors.orange,size: 20,),
                          color: Colors.grey,
                          shape: CircleBorder(),
                          elevation: 1,
                        ),
                      )
                    ],
                  ),
                  //for adding some space, we can use sized box
                  SizedBox(height: mq.height * .019,),

                  Text(widget.user.email,style: TextStyle(color: Colors.black54,fontSize: 16),),
                  //for adding some space, we can use sized box
                  SizedBox(height: mq.height * .04,),

                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val)=>val != null && val.isNotEmpty ? null : 'Required Field' ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: "eg. Mickey Mouse",
                      prefixIcon: Icon(Icons.person,),
                      label: Text("Name")
                    ),
                  ),

                  //for adding some space, we can use sized box
                  SizedBox(height: mq.height * .03,),

                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val)=>APIs.me.about = val ?? '',
                    validator: (val)=>val != null && val.isNotEmpty ? null : 'Required Field' ,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: "eg. Feeling Happy",
                        prefixIcon: Icon(Icons.info),
                        label: Text("About")
                    ),
                  ),

                  //for adding some space, we can use sized box
                  SizedBox(height: mq.height * .05,),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(minimumSize: Size(mq.width * .5,mq.height * .06),backgroundColor: Colors.greenAccent),
                      onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        //print('inside validator');
                        APIs.updateUSerInfo().then((value){
                          Dialogs.showSnackbar(context, 'Profile Updated Successfully');
                        });
                      }
                      },
                      label: Text("Update",style: TextStyle(fontSize: 23,color: Colors.white),),
                    icon: Icon(Icons.edit,color: Colors.white,size: 25,),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

