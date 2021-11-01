import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/notes/add_notes.dart';
import 'package:flutter_quiz/screens/notes/view_note.dart';
import 'package:intl/intl.dart';

class YourNotesScreen extends StatefulWidget {

  @override
  _YourNotesScreenState createState() => _YourNotesScreenState();
}

class _YourNotesScreenState extends State<YourNotesScreen> {
  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: FutureBuilder<QuerySnapshot>(
     
      builder: (context , snapshot){
        if(snapshot.hasData){
           if (snapshot.data.docs.length == 0 ) {
              return Container(
                 color: Color.fromRGBO(255, 245, 214, 1),
                child: Center(
                  child: Text(
                    "You have not made any notes yet!",
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
                DateTime dateTime = data['time'].toDate();
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius:BorderRadius.circular(5) ,
                    onTap:() => Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (context) => 
                      ViewNote(data, DateFormat.yMMMd().add_jm().format(dateTime).toString(), snapshot.data.docs[index].reference)
                      )
                    ).then(
                      (value) {
                        setState((){});
                      }
                    ),
                    child: Container(
                      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromRGBO(	144, 173, 198, 1), Color.fromRGBO(71,75,113, 1), Color.fromRGBO(22,23,35, 1)])
  ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Container(
                             padding: const EdgeInsets.all(15.0),
                             child: Text("${data['title']}", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),),
                           ),
                           SizedBox(height: 7),
                           Container(
                             alignment: Alignment.centerRight,
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               "${DateFormat.yMMMd().add_jm().format(dateTime)}", style: TextStyle(fontSize: 15,  color: Colors.white70), textAlign: TextAlign.center,),
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
    ),
    floatingActionButton: FloatingActionButton(
                            onPressed: () =>  Navigator.of(context).push(
                                             MaterialPageRoute(
                                           builder: (context) => AddNote() )
                                           ).then((value){
                                             setState(() {
                                               
                                             });
                                           }), 
                            child: Icon(Icons.add, color:Colors.amber, size: 40,),
                            backgroundColor: Colors.red,
                            ),
    );
  }
}