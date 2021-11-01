
import 'dart:async';
import 'dart:math' as math ;

import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/signinpage.dart';


class AnimationPage extends StatefulWidget {

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {
 
 AnimationController animationController;
 Animation<double> animation;


 @override
  void initState() {
    super.initState();
     Timer(Duration(seconds: 7), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context ) => SignInPage()  )
      );
    } );
    animationController = AnimationController(duration: Duration(seconds: 3),
    vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut
      );

    animation = Tween<double>(begin: 0,end: 2*math.pi ).animate(curvedAnimation)..addListener(() {
      setState(() { });
    })
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed){
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: animation.value,
        child: Container(
          alignment: Alignment.center,
          child: Image.asset('images/logo.png', height: 1000,fit:BoxFit.cover,),
          ),
        ),
        backgroundColor: Color.fromRGBO(30,46,89, 0.8),
    );
  }

  @override
  void dispose() {
  animationController.dispose();
    super.dispose();
  }
}