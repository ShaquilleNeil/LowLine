import 'package:flutter/material.dart';
import 'package:lowline/features/auth/presentation/screens/signup.dart';
import 'package:lowline/services/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            
              children: [
                Text("Welcome to LowLine!"),
                SizedBox(height: 20),
                  Form(
                    key: _formGlobalKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formGlobalKey.currentState!.validate()) {
                              // Process login
                              try {
                                await _authService.signInWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              } on FirebaseAuthException catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.message ?? 'Login failed')),
                                  );
                                }
                              
                              }
                              
                            }
                          },
                          child: Text('Login'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                // Navigate to signup screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Signup()),  
                                );
                              },
                              child: Text('Sign up'),
                            ),
                          ],
                        )
                       
                      ],
                    ),
                  )
              ],
            ),
          )
        )
      ),
    );
  }
}