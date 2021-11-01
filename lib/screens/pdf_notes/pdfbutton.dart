import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/pdf_notes/pdf_api.dart';
import 'package:flutter_quiz/screens/pdf_notes/pdf_viewer.dart';

class PDFElevatedButton extends StatelessWidget {
   final path ;
   final title ;

   PDFElevatedButton( this.path,  this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 350),
                 child: ElevatedButton(
                   style: ButtonStyle(
                     backgroundColor:MaterialStateProperty.all(Color.fromRGBO(	62, 69, 128, 1)),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 30)),
                       shape:MaterialStateProperty.all( RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)))
                     ),
                   onPressed:() async {
                   final p = path;
                    final file = await PDFApi.loadAsset(p);
                   openPDF(context,file);
                 },
                  child: Text(title, style: TextStyle(fontSize: 20, color: Colors.white), ),
                  
                  ),
               ),
    );

    
  }
   void openPDF(BuildContext context, File file) 
   => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PDFViewer(file)
        ),
      );
}