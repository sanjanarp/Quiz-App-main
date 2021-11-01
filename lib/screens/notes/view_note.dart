
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewNote extends StatefulWidget {
   final Map data;
   final String time;
   final DocumentReference ref;

   ViewNote( this.data, this.time,this.ref);


  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title = '';
  String description = '';
  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     title = widget.data['title'];
     description = widget.data['description'];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.data['title']}"),
         actions:  <Widget>[
            
     edit?  Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: IconButton(
        onPressed: () {
          save();
          if(key.currentState.validate()){
           final snackBar = SnackBar(
              content: Row(
                  children: [
                     Icon(Icons.note_add, color: Colors.amber,),
                     SizedBox(width: 5,),
                     Text('Note Updated!'),
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
    ):IconButton(
       onPressed: (){
         setState(() {
           edit=!edit;
         });
       },
       tooltip: "Edit",
       icon: Icon(
         Icons.edit,
         size: 26.0,
       ),
     ),
    Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: IconButton(
        onPressed:(){
          delete();
           final snackBar = SnackBar(
              content: Row(
                  children: [
                     Icon(Icons.warning, color: Colors.amber,),
                     SizedBox(width: 5,),
                     Text('Note deleted!'),
                  ],
                ),
                 duration: Duration(seconds: 1),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        tooltip: "Delete",
        icon: Icon(
          Icons.delete,
          color: Colors.red[900],
          size: 26.0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
            
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
                           decoration: InputDecoration.collapsed(hintText: "Title"),
                           style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                           initialValue: widget.data['title'],
                           enabled: edit,
                           onChanged: (value) {title = value;},
                           validator: (value){
                             if(value.isEmpty)
                               return "Cannot be empty!";
                             else return null;
                           },
                         ),
                   ),
                 
                   Container(
                      alignment: Alignment.centerRight,
                     padding: const EdgeInsets.all(10),
                     child: Text(
                       "${widget.time}",
                       style: TextStyle(fontSize: 15, color: Colors.black87),
                     ),
                   ),
                    Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                   Container(
                     height: MediaQuery.of(context).size.height * 0.75,
                     padding: const EdgeInsets.all(15),
                     child: TextFormField(
                         decoration: InputDecoration.collapsed(hintText: "Start your note here..."),
                         style: TextStyle(fontSize: 20,),
                         initialValue: widget.data['description'],
                         enabled: edit,
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
              ),
            ),

          ],
        ),
      ),
    );
  }

  void delete() async{
    
    await widget.ref.delete();
    Navigator.pop(context);

  }

  void save() async {
    if(key.currentState.validate()){
    await widget.ref.update(
      {'title': title,
       'description': description}
       );
       Navigator.of(context).pop();
  }  
  }


}