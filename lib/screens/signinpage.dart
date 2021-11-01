import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/controller/google_auth.dart';
import 'package:flutter_quiz/screens/quiz screens/home_screen.dart';
import 'package:flutter_quiz/screens/login_screen.dart';
import 'package:provider/provider.dart';


class SignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: StreamBuilder<Object>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
             final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
               if(provider.isSigningIn){
                 return buildLoading();
               }  else if(snapshot.hasData){
                      return HomeScreen();
               }
               else{
                  return LoginScreen();
               }
           
          }
        ),
      ) );
  }
  Widget buildLoading() => Center(child: CircularProgressIndicator(),);
}