import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz screens/answer.dart';

class ViewBookmarked extends StatefulWidget {
  final Map data;
  final List options;
  final DocumentReference r;
  final String correctAns;
  final String explanation;

  ViewBookmarked(this.data, this.options, this.r, this.correctAns, this.explanation);

  @override
  _ViewBookmarkedState createState() => _ViewBookmarkedState();
}

class _ViewBookmarkedState extends State<ViewBookmarked> {

  bool answerSelected = false;
  bool correctAnswerSelected = false;
  String selectedAns;

 void delete(DocumentReference r) async {
    await r.delete();
    Navigator.pop(context);
  }

   void _questionAnswered(bool score, String text) {
       selectedAns = text;
      setState(() {
        answerSelected = true;
        if(score){
           correctAnswerSelected = true;
          }

      });
   }

   _popupDialogExp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Explanation'),
            content: Text(widget.explanation),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CLOSE')),
            ],
          );
        });
  }


  Color getColor(String text, String correctAns, bool score){
    if(answerSelected) {
      if(text == correctAns){
        return Colors.green;
      } else if(text == selectedAns && selectedAns!=correctAns){
        return Colors.red;
      }
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.data['topic']}") ,),
      body: Container(
        padding: EdgeInsets.all(10),
         child:  Column(
           children: [
             Expanded(
               child: Card(
                  margin: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                       // color: Colors.green,
                        child: Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color.fromRGBO(	144, 173, 198, 1), Color.fromRGBO(71,75,113, 1), Color.fromRGBO(22,23,35, 1)])
  ),
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                          children: [  
                             Text(widget.data['question'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                             SizedBox(height: 20),
                               ...(widget.options)
                      .map(
                    (answer) => Answer(
                      answer['text'],
                     getColor(answer['text'], widget.correctAns, answer['score']),
                     //Colors.amber,
                        // if answer is already selected then nothing happens onTap
                       () {
                         if (answerSelected) {
                             return; 
                         } else  
                         _questionAnswered(answer['score'], answer['text']);
                         
                        }
                        //answer is being selected
                       
                        
                       
                        ),
                      ),
                               SizedBox(height: 10),
                               
                                 if(answerSelected)  ElevatedButton(
                                 onPressed: () => _popupDialogExp(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Explanation"),
                                  ),
                                ),
                                      
                               SizedBox(height: 10),

                      
                          ],
                      
                        ),
               ),
               ),
             ),
           ],
         ),
        ),
        floatingActionButton:  FloatingActionButton(
                                 onPressed: () {
                                   delete(widget.r);
                                   final snackBar = SnackBar(content: Row(
                                         children: [
                                           Icon(Icons.bookmark_remove, color: Colors.amber,),
                                           SizedBox(width: 5,),
                                           Text('Removed from Bookmarks'),
                                         ],
                                       ),
                                       duration: Duration(seconds: 1),);
                                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                   
                                   }, 
                                 child: Icon(Icons.delete, color:Colors.amber, ),
                                 backgroundColor: Colors.red,
                                 ),
    );
  }
}