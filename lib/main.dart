import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:we_text_2/screens/auth/login_screen.dart';
import 'package:we_text_2/screens/home_screen.dart';
import 'package:we_text_2/screens/splash_screen.dart';
import 'firebase_options.dart';

//Global object for accessing Screen Size
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //To show splash screen to full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //For setting orientation to portrait mode only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]).then((value){
    _initializeFirebase();
    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Text',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.black54,
            titleTextStyle: TextStyle(
                fontSize: 30,
                color: Colors.white,
                //fontFamily: 'Font1',
                fontWeight: FontWeight.normal)
        )
      ),
      home: SplashScreen(),
    );
  }
}

_initializeFirebase() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

//Media query can be initialised in the build function whose parent is App
//Here it is Splash Screen

//made a repo on github and pushed the project