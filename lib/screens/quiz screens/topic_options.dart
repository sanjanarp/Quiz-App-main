import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz screens/custom_card.dart';


class TopicOptions extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(255, 245, 214, 1),
        child: ListView(
          children: [
          SizedBox( height: 10 ,),
          CustomCard("Basics of Operating System", "images/os.png"),
          SizedBox( height: 10 ,),
          CustomCard("Process Scheduling","images/schedule.png"),  
          SizedBox( height: 10 ,),
          CustomCard("Deadlocks","images/deadlock.png"),  
          SizedBox( height: 10 ,),
          CustomCard("Memory Management","images/vmm.png"),  
          SizedBox( height: 10 ,),
          CustomCard("Storage", "images/storage.png"),  
        ],),
      );
  }
}