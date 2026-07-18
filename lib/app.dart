import 'package:flutter/material.dart';
import 'package:lowline/core/routing/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lowline/features/auth/presentation/screens/login.dart';
import 'package:lowline/core/theme/app_theme.dart';
// MaterialApp/router setup, empty for now.
class LowLineApp extends StatelessWidget {
  const LowLineApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
     home:StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(body: Center(child: CircularProgressIndicator())); // CircularProgressIndicator();
          }
          else if(snapshot.hasData){
            return const BottomNav();
          }
          else{
            return LoginScreen();
          }
        },
      ),
     
    );
  }
}
