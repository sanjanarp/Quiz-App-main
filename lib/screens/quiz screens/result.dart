import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final int totalNumberofQuestions;

  Result(this.resultScore, this.resetHandler, this.totalNumberofQuestions);

  String get resultPhrase{
    var resultText = 'Score: ';
    if(resultScore >= 0){
      resultText += resultScore.toString();
    }
    return resultText + "/$totalNumberofQuestions" ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Center(
           child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            
            Text(resultPhrase, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 45.0, color: Colors.white),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Container(
             height: 50,
              child: ElevatedButton(
                         style:  ElevatedButton.styleFrom(
                    primary: Colors.white,
                   // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30.0),
                   ), ),
                  onPressed: resetHandler ,
                  child: Text('RESTART QUIZ',
                    style: TextStyle( color: Colors.black, fontSize: 20),)
                    ),
            ),
          ],
        )),
      ),
    );
  }
}
