import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_text_2/helper/dialogs.dart';
import 'package:we_text_2/main.dart';
import 'package:we_text_2/screens/home_screen.dart';

import '../../api/apis.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  bool isAnimate = false;

  //One example from animation widgets flutter site
  // late AnimationController _controller = AnimationController(
  //     duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..reset();
  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: Offset.zero,
  //   end: const Offset(1.5, 0.0),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.elasticIn,
  // ));
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 500), (){
      setState(() {
        isAnimate = !(isAnimate);
      });
    });
  }

  _handleGoogleButtonClick(){
    //To show Progress Loader
    Dialogs.showProgressLoader(context);

    _signInWithGoogle().then((user) {
      //To remove Progress Loader
      Navigator.pop(context);
      if(user != null){
        print("\nUser: ${user.user}");
        print("\nUser Additional Info: ${user.additionalUserInfo}");
        //It will redirect to homescreen after login
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const HomeScreen()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try{
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e){
      print('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'No internet connection! Please check and try again...');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    //mq = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome to We Text!')
      ),
      body: Stack(
        children: [
          //App Logo
          // SlideTransition(
          //   position: _offsetAnimation,
          //   child: Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: Image.asset('assets/images/phone.png'),
          //   ),
          // ),

          AnimatedPositioned(
            top: mq.height * .15,
              width: mq.width * .5,
              right: isAnimate ? mq.width * .25 : -mq.width * .5,
              child: Image.asset('assets/images/phone.png'),
            duration: Duration(seconds: 1),
          ),

          //Google login button
          Positioned(
              bottom: mq.height * .30,
              width: mq.width * .9,
              left: mq.width * .07,
              height: mq.height * .07,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[350]
                ),
                  onPressed: (){
                  _handleGoogleButtonClick();
                  },
                  icon: Image.asset('assets/images/google.png',height: mq.height * .0305,),
                  label: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20
                      ),
                      children: [
                        TextSpan(text: 'Login with '),
                        TextSpan(text: 'Google',style: TextStyle(fontWeight: FontWeight.w900)),
                      ]
                    ),
                  ),
              )
          ),

          //Mail login Button
          Positioned(
              bottom: mq.height * .20,
              width: mq.width * .9,
              left: mq.width * .07,
              height: mq.height * .07,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[350]
                ),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                },
                icon: Icon(Icons.email,size: mq.height * .035,),
                label: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 21
                      ),
                      children: [
                        TextSpan(text: 'Login with '),
                        TextSpan(text: 'Email',style: TextStyle(fontWeight: FontWeight.w900)),
                      ]
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}