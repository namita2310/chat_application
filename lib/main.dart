import 'package:chatbot/screens/auth_screen.dart';
import 'package:chatbot/screens/splash_screen.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:chatbot/screens/chat_screen.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Letter1',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Colors.purple,
        accentColor: Colors.pink,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, snapshot) {
          
          if(snapshot.connectionState==ConnectionState.waiting)
          return SplashScreen();
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
