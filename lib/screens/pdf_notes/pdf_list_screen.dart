

import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/pdf_notes/pdfbutton.dart';

class PDFListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(255, 245, 214, 1),
     body: Container(
       child: SingleChildScrollView(
           child: Center(
             child: Column(
               children: [
                 SizedBox(height: 20,),
                  PDFElevatedButton('assets/Basics of Operating System.pdf', 'Basics of Operating System'),
                   SizedBox(height: 20,),
                  PDFElevatedButton('assets/Process Scheduling.pdf',"Process Scheduling"),
                   SizedBox(height: 20,),
                  PDFElevatedButton('assets/Deadlocks.pdf',"Deadlocks" ),
                  SizedBox(height: 20,),
                  PDFElevatedButton('assets/Memory Management.pdf',"Memory Management" ),
                 SizedBox(height: 20,),
                 PDFElevatedButton('assets/Storage.pdf',"Storage" )
                 
               ],
             ),
           ),
         ),
     ),
    );
  }
  

}