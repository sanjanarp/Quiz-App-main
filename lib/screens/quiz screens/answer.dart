import 'package:flutter/material.dart';



class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final Function answerTap;


  Answer( this.answerText,this.answerColor, this.answerTap );


 
  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
       
       child:  ElevatedButton(
         style:  ElevatedButton.styleFrom(
                primary: Colors.blueGrey[200],
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(30.0),
               side: BorderSide(color: answerColor)
               ),
                textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500)),
         onPressed:answerTap,
         child: Container(
           height: MediaQuery.of(context).size.height/20,
           width: MediaQuery.of(context).size.width/2,
           margin: EdgeInsets.all(10),
           child: Center(
             child: Wrap(
               children:[
                 Text(answerText, 
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 20.0, color: answerColor
                       ),
                      ),
                ], 
             ),
           ),
         ),
       ),
    );
  }
}

