

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quiz/screens/quiz screens/result.dart';
import "package:flutter_quiz/question_list/question_list.dart" as questionlist1;
import "package:flutter_quiz/question_list/question_list2.dart" as questionlist2;
import "package:flutter_quiz/question_list/question_list3.dart" as questionlist3;
import "package:flutter_quiz/question_list/question_list4.dart" as questionlist4;
import "package:flutter_quiz/question_list/question_list5.dart" as questionlist5;
import 'package:flutter_quiz/screens/quiz screens/home_screen.dart';
import 'answer.dart';

class Body extends StatefulWidget {
String topic;
Body(this.topic);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
 
  selectQL(String topic){
    var selectedql;

  if( topic == "Basics of Operating System"){
     return selectedql = questionlist1.questionslist;
  } else if(topic=="Process Scheduling") {
    return selectedql = questionlist2.questionslist;
  } else if(topic=="Deadlocks") {
    return selectedql = questionlist3.questionslist;
  } else if(topic=="Memory Management") {
    return selectedql = questionlist4.questionslist;
  } else if(topic=="Storage") {
    return selectedql = questionlist5.questionslist;
  } 
 }
 
 var _questionIndex =0;
  var _totalScore =0;
  List<Icon> _scoreTracker = [];
  List<String> bookmarkList = [];
  bool answerSelected = false;
  bool correctAnswerSelected = false;
  bool endOfQuiz = false;
  String selectedAns;
  bool isBookmarked = false;
   var id;


 
  void _resetQuiz(){
    setState(() {
      _questionIndex =0;
      _totalScore =0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }
   void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerSelected = false;
      correctAnswerSelected = false;
     
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


    void _questionAnswered(bool score, String answerText) {
      print(answerText);
       selectedAns = answerText;
      setState(() {
        answerSelected = true;
        if(score){
          _totalScore++; 
          correctAnswerSelected = true;
          }
          _scoreTracker.add(
            score
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.clear,
                color: Colors.red,
              ),
          );
           if (_questionIndex + 1 == selectQL(widget.topic).length) {
        endOfQuiz = true;
      }
      });

      CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('answers');
 
  var data = {
    'topic': widget.topic,
    'question':selectQL(widget.topic)[_questionIndex]['questionText'],
    'answer': selectedAns,
    'options':(selectQL(widget.topic)[_questionIndex]['answers']
                          as List<Map<String, Object>>),
    'time': DateTime.now(),
  };

  ref.add(data);
// ref.orderBy('topic');
    } 

    void add() async{

        CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('bookmarks');
    var data = {
    'topic': widget.topic,
    'question': selectQL(widget.topic)[_questionIndex]['questionText'],
    'correct_answer':  selectQL(widget.topic)[_questionIndex]['correctAns'],
    'explanation':selectQL(widget.topic)[_questionIndex]['explanation'],
    'options':(selectQL(widget.topic)[_questionIndex]['answers']
                          as List<Map<String, Object>>),
    'time': DateTime.now(),
  };
  
   id= await ref.add(data).then(
    (value) {    
     // print(value.id);
      String qid = value.id;
       return qid;
    }
  );
  
   print(id);
  ref.orderBy('time', descending: true);
      } 

   _popupDialogExp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Explanation'),
            content: Text(selectQL(widget.topic)[_questionIndex]['explanation']),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CLOSE')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          ),
      child: Scaffold(
         backgroundColor: Colors.transparent,
          appBar: AppBar(
           flexibleSpace: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Color.fromRGBO(	144, 173, 198, 1) , Color.fromRGBO(71,75,113, 1) 
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            leading: IconButton(
             icon: Icon(Icons.home, color: Colors.white,),
             onPressed: () { Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())); },
             ),

          title: Text(widget.topic, style: TextStyle(color: Colors.white),),

        ),
          body:
               (_questionIndex < selectQL(widget.topic).length )? 
                Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                   Expanded(
                     child: Card( 
                        margin: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        child: Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(	144, 173, 198, 1), Color.fromRGBO(71,75,113, 1), Color.fromRGBO(22,23,35, 1)])
            ),
                          child: Stack(
                            children:<Widget>[
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                IconButton(
                                  onPressed: (){
                                   setState(() {
                                     isBookmarked = !isBookmarked;
                                   });
                                     if(isBookmarked){
                                      bookmarkList.add("${selectQL(widget.topic)[_questionIndex]['questionText']}");
                                     add();
                                     final snackBar = SnackBar(content: Row(
                                         children: [
                                           Icon(Icons.bookmark_add, color: Colors.amber,),
                                           SizedBox(width: 5,),
                                           Text('Saved in Bookmarks'),
                                         ],
                                       ),
                                       duration: Duration(seconds: 1),
                                       );
                                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else if(isBookmarked && bookmarkList.contains("${selectQL(widget.topic)[_questionIndex]['questionText']}")){
                                            bookmarkList.remove("${selectQL(widget.topic)[_questionIndex]['questionText']}");
                                            final snackBar = SnackBar(content: Row(
                                         children: [
                                           Icon(Icons.bookmark_remove, color: Colors.amber,),
                                           SizedBox(width: 5,),
                                           Text('Removed from Bookmarks'),
                                         ],
                                       ),
                                       duration: Duration(seconds: 1),
                                       );     
                                    }
                                  }, 
                                  icon: (isBookmarked && bookmarkList.contains("${selectQL(widget.topic)[_questionIndex]['questionText']}")
                                  ? Icon(Icons.bookmark, size: 30, )  : Icon(Icons.bookmark_border_outlined, size: 30, )),),
                                SizedBox(height: 20,),
                                Center(
                                      child: Text( 
                                       "${_questionIndex + 1}. ${selectQL(widget.topic)[_questionIndex]['questionText']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                      ...(selectQL(widget.topic)[_questionIndex]['answers']
                              as List<Map<String, Object>>)
                          .map(
                        (answer) => Expanded(
                          child: Answer(
                            answer['text'],
                            getColor(answer['text'], selectQL(widget.topic)[_questionIndex]['correctAns'], answer['score']),
                              // if answer is already selected then nothing happens onTap
                             () {
                               if (answerSelected) {
                                return;
                                
                              }
                              //answer is being selected
                             else  
                               _questionAnswered(answer['score'], answer['text']);
                               
                            }
                             
                              ),
                        ) ,
          
                                ),
                                SizedBox(height: 20,),
                               
                               ]
                               ) 
                               ], )
              )
                  ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       if(answerSelected)  ElevatedButton(
                                     onPressed: () => _popupDialogExp(context),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Explanation"),
                                      ),
                                    ),
                       ElevatedButton(
                                      onPressed: (){
                                        if(!answerSelected){
                                           final snackBar = SnackBar(content: Row(
                                             children: [
                                               Icon(Icons.warning_amber, color: Colors.amber,),
                                               SizedBox(width: 5,),
                                               Text('Please select an answer'),
                                             ],
                                           ),
                                           duration: Duration(seconds: 1),);
                                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        } else {
                                          _nextQuestion();
                                        }
                                      },
                                    child: endOfQuiz? Text("Results") : Text("Next Question"),
                                    ),
                                   
                     ],
                   ),
                                 SizedBox(height: 14,),
                  ],
                 ),
          ): Result(_totalScore , _resetQuiz, selectQL(widget.topic).length) ),
    );

  }

}



