

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz/controller/google_auth.dart';
import 'package:flutter_quiz/screens/bookmark/bookmark_screen.dart';
import 'package:flutter_quiz/screens/login_screen.dart';
import 'package:flutter_quiz/screens/pdf_notes/pdf_list_screen.dart';
import 'package:flutter_quiz/screens/quiz screens/topic_options.dart';
import 'package:flutter_quiz/screens/notes/your_notes_screen.dart';
import 'package:provider/provider.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
     final drawerItems = [
     DrawerItem("Quizzes", Icons.home),
     DrawerItem("Bookmarks ", Icons.bookmarks),
     DrawerItem("PDF Notes", Icons.note),
     DrawerItem("Your Notes", Icons.note_alt_outlined),
  ];
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final user = FirebaseAuth.instance.currentUser;
  int _selectedDrawerIndex = 0;

   _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return TopicOptions();
      case 1:
        return  BookmarkScreen();
      case 2:
        return  PDFListScreen();
      case 3:
        return  YourNotesScreen();
      default:
        return Center(child: Text("Error!"));
    }
  }

    _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('LOGOUT ALERT!'),
            content: Text('Are you sure you want to logout?'),
            actions: <Widget>[
              TextButton(
                 onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              Navigator.of(context).pop();
               Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context ) => LoginScreen()  )
      );
                },
                  child: Text('YES'),
                  ),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CANCEL')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp
    ]);
     List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return WillPopScope(
      onWillPop: () {
        if (_selectedDrawerIndex != 0) {
          setState(() {
            _selectedDrawerIndex = 0;
          });
          _getDrawerItemWidget(_selectedDrawerIndex);
        } else {
          Navigator.pop(context, true);
        }
        return;
      },
    child: Scaffold(
      appBar: AppBar(
         title: Text(widget.drawerItems[_selectedDrawerIndex].title),
         actions:  <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: IconButton(
        onPressed:() => _popupDialog(context),
        icon: Icon(
          Icons.logout,
          size: 26.0,
        ),
      )
    ),

         ],
      ),
      drawer: Drawer(
        
         child: Column(
           children: [
             UserAccountsDrawerHeader(
               accountName: Text(user.displayName, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,),) ,
                accountEmail: Text(user.email, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                currentAccountPicture: CircleAvatar( backgroundImage: NetworkImage(user.photoURL),),
                ),
               Column(children: drawerOptions,),
           ],
         ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    )
    );
  }
}

