import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/bookmark/view_bookmarked.dart';



class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
 CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('bookmarks');
 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
     
      builder: (context , snapshot){
        if(snapshot.hasData){
           if (snapshot.data.docs.length == 0 ) {
              return Container(
                 color: Color.fromRGBO(255, 245, 214, 1),
                child: Center(
                  child: Text(
                    "You have no bookmarks yet!",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }
          return Container(
             color: Color.fromRGBO(255, 245, 214, 1),
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index) {
                Map data = snapshot.data.docs[index].data();
                List options = data['options'];
                String correctAns = data['correct_answer'];
                String explanation = data['explanation'];
                DocumentReference r = snapshot.data.docs[index].reference;
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius:BorderRadius.circular(5) ,
                    onTap:() => 
                    Navigator.of(context).push(
                      MaterialPageRoute(
                      builder: (context) => ViewBookmarked(data, options, r, correctAns, explanation)
                      )
                    ).then((value) {
                      setState(() {
                        
                      });
                    }),
                    child: Container(
                      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromRGBO(	144, 173, 198, 1), Color.fromRGBO(71,75,113, 1), Color.fromRGBO(22,23,35, 1)])
  ),
                      child: Column(
                        children: [
                           Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Text("${data['topic']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white70),),
                           ),
                           SizedBox(height: 7),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(data['question'], style: TextStyle(fontSize: 15,  color: Colors.white), textAlign: TextAlign.center,),
                           ),
                           SizedBox(height: 13),
                        ],
                      ),
                    ),
                  ),
                );
              }
              ),
          );
        } else {
          return Center(child: Text("Loading"),);
        }
      },
      future: ref.get(),
    );
  }
}