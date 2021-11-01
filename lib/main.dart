
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/animation_page.dart';
import 'package:flutter_quiz/controller/google_auth.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //to ensure that all widgets are initialized (this line of code is written after setting up firebase to make sure it is set up properly)
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Quiz',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: AnimationPage(),
        debugShowCheckedModeBanner: false,

      ),
    );
  }
}

