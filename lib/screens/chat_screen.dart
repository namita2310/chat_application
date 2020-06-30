import 'package:chatbot/widgets/chat/messages.dart';
import 'package:chatbot/widgets/chat/new_messages.dart';
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm=FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg){
      print(msg);
      return ;
    },onLaunch: (msg){
      print(msg);
      return;
    },onResume: (msg){
      print(msg);
      return;
    });
    fbm.subscribeToTopic("chat");
    // TODO: implement initState
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LetterChat"),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text("logout"),
                      ],
                    ),
                  ),
                  value: "logout",
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == "logout") FirebaseAuth.instance.signOut();
              }),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     // print(data);
      //     Firestore.instance
      //         .collection('/chats/3jK565MKjXCw5jba7saI/messages')
      //         .add({
      //       "text": "this was added by clicking button",
      //     });
      //   },
      // ),
    );
  }
}
