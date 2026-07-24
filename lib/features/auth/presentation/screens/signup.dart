import 'package:flutter/material.dart';
import 'package:lowline/services/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lowline/services/firebase/firestore_service.dart';




class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formGlobalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final AuthService _authService = AuthService();
  final FirestoreService _fireStoreService = FirestoreService();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
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
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 35),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formGlobalKey.currentState!.validate()) {
                              // Process sign up
                              try {
                                  final User? user = await _authService.signUpWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                  if (user !=null){
                                    await _fireStoreService.createPersonalSpace(user.uid);
                                  }
                                  if (context.mounted){
                                    Navigator.pop(context);
                                  }
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message ?? 'Sign up failed')),
                                );
                              }
                              
                            }
                          },
                          child: Text('Sign Up'),
                        ),
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