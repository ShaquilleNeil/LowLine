import 'package:flutter/material.dart';
import 'package:lowline/services/firebase/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
 

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
   final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Screen'),
            ElevatedButton(
              onPressed: () async => await _authService.signOut(), // Placeholder for logout functionality
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
