
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNote extends StatefulWidget {

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title = '';
  String description = '';
 GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
         actions:  <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: IconButton(
        onPressed:(){
            add();
            if(key.currentState.validate()){
            final snackBar = SnackBar(
              content: Row(
                  children: [
                     Icon(Icons.note_add, color: Colors.amber,),
                     SizedBox(width: 5,),
                     Text('Note Added!'),
                  ],
                ),
                 duration: Duration(seconds: 1),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
        },
        tooltip: "Save",
        icon: Icon(
          Icons.save,
          size: 26.0,
          color: Colors.black87,
        ),
      )
    ),

         ],
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: key,
              child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: TextFormField(
                       decoration: InputDecoration.collapsed(hintText: "Title"),
                       style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                       onChanged: (value) {title = value;},
                       validator: (value){
                             if(value.isEmpty)
                               return "Cannot be empty!";
                             else return null;
                           },
                     ),
                   ),
                    Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                   Container(
                     height: MediaQuery.of(context).size.height * 0.75,
                     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                     child: TextFormField(
                       decoration: InputDecoration.collapsed(hintText: "Start your note here..."),
                       style: TextStyle(fontSize: 20,),
                       onChanged: (value) {description = value;},
                       maxLines: 40,
                       validator: (value){
                             if(value.isEmpty)
                               return "Cannot be empty!";
                             else return null;
                           },
                     ),
                   ),
                   
                 ],
            )
            ),

          ],
        ),
      ),
    );
  }

  void add() async{
    if(key.currentState.validate()){
    CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('notes');
   var data = {
     'title' : title,
     'description': description,
     'time': DateTime.now()
         };

    ref.add(data);

    Navigator.pop(context);

  }
  }



}