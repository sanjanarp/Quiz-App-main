import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

// ignore: missing_return
Future<bool> login(BuildContext context) async{
    isSigningIn = true;
  try{
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if(googleSignInAccount != null){
  final   GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,);

      final UserCredential authResult = await auth.signInWithCredential(credential);
      final User user = authResult.user;
        isSigningIn = false;
      
      var userData = {
        'name' : googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email':googleSignInAccount.email,
      };

       users.doc(user.uid).get().then((doc)  {
         if(doc.exists){
           doc.reference.update(userData);

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context ) => HomeScreen()  )
      );
       print("Signed in as ${googleSignInAccount.email}");

         } else{
           users.doc(user.uid).set(userData);

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context ) => HomeScreen()  )
      );
       print("Signed in as ${googleSignInAccount.email}");
         }
       }
       );


  }
  } catch(PlatformException) {
print(PlatformException);
print("Sign in not successful");
  }
  
}

  // Future login() async {
  //   isSigningIn = true;

  //   final user = await googleSignIn.signIn();
  //   if (user == null) {
  //     isSigningIn = false;
  //     return;
  //   } else {
  //     final googleAuth = await user.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await FirebaseAuth.instance.signInWithCredential(credential);

  //     isSigningIn = false;
  //   }
  // }

  void logout() async {
    try{ await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    
    }
    catch(PlatformException){
       print(PlatformException);
print("Sign out not successful");
    }
   
 
    
  }
}

