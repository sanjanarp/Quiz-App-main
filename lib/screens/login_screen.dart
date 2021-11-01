import 'package:flutter/material.dart';
import 'package:flutter_quiz/controller/google_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("images/backgroundf.png"),
              fit: BoxFit.fitHeight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Container(
              //   height: 500,
              //   color: Colors.pink,
              // ),
              // Container(
              //   child: Image.asset('images/backgroundf.png'),
              // ),
             Container(
               width: double.infinity,
              color: Color.fromRGBO(5, 26, 61, 0.8),
               child: Text("Ready to take up quiz?!", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400, color: Colors.white),
               ),
               padding: EdgeInsets.all(25),
               ),
             Padding(
               padding: const EdgeInsets.all(25.0),
               child: ElevatedButton(
                 onPressed: (){
                    final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.login(context);
                 }, 
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Continue with google", style: TextStyle(fontSize: 20,color: Colors.white),),
                     SizedBox(width: 10,),
                     Image.asset('images/google.png', height: 20)
                   ],
                 ),
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Color.fromRGBO(240, 36, 56, 0.7))
                 ),
                 
                 ),
             ),
               SizedBox(
                 height: 20,
               )
            ],
          
          ),
        ),
      ),
      
    );
  }
}