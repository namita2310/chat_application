import 'package:chatbot/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: Firestore.instance
                .collection("chat")
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              final chatdocs = snapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) => MessageBubble(
                   chatdocs[index]["text"],
                   
                   chatdocs[index]["userId"] == futureSnapshot.data.uid,
                   chatdocs[index]["userimage"],
                   chatdocs[index]["username"],
                  ValueKey(chatdocs[index].documentID),

                ),
                itemCount: snapshot.data.documents.length,
              );
            },
          );
        });
  }
}
                  
