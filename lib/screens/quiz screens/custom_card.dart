import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz screens/quiz_body.dart';

class CustomCard extends StatelessWidget {
  
  String text;
  String img;
  CustomCard(this.text, this.img);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 45),
              
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(	144, 173, 198, 1), Color.fromRGBO(71,75,113, 1), Color.fromRGBO(22,23,35, 1)])
  ),
                padding: EdgeInsets.all(30.0),
                child: InkWell(
                  splashColor: Colors.white38,
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => (Body(text))));
                  },
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Center(
                        child: Text(text, style: TextStyle(fontSize: 24, color: Colors.white),),
                      ),
                    
                    
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            height: 80,
            width: 20,
            child: Image(image: AssetImage(img), ),
          ),
        ),
      ],
      
    );
  }
}
