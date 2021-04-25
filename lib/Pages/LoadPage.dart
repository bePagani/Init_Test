import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:flutter_app/Pages/LoginPage.dart';
import 'package:flutter_app/Pages/constans.dart';

class LoadPage extends StatelessWidget {
  final Future<FirebaseApp>_init=Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot){

        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text("Ошибка ${snapshot.error}"),
            ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, Streamsnapshot){
              if(Streamsnapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text("Ошибка ${Streamsnapshot.error}"),
                  ),
                );
              }

              if(Streamsnapshot.connectionState==ConnectionState.active){
                User user = Streamsnapshot.data;

                if(user ==null){
                  return LoginPage();

                }
                else{
                  return HomePage();
                }
              }
              return Scaffold(
                body: Center(
                  child: Text("FireBase auth."),
                ),
              );
            },
          );

        }
        return Scaffold(
          body: Center(
            child: Text("initialization..."),
          ),
        );
      },
    );
  }
}
