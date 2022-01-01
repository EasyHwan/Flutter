import 'package:flutter/material.dart';
import 'package:instgram_clon/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instgram_clon/login_page.dart';
import 'login_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return TabPage(snapshot.data);
        } else {
          return LoginPage();
        }
      },
    );
  }
}

