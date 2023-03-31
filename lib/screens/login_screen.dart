import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool isLoading = false;

  Future<void> login() async {
    // saritayadav1609@gmail.com

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      if (email != 'saritayadav1609@gmail.com') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Invalid email or password',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        );

        setState(() {
          isLoading = false;
        });

        return;
      }

      try {
        final usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (usercredential.user != null) {
          if (mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName,
              (route) => false,
            );
          }

          setState(() {
            isLoading = false;
          });

          return;
        }
      } on FirebaseAuthException catch (error) {
        if (error.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.message!,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          );
        }

        setState(() {
          isLoading = false;
        });

        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 350,
          width: 550,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Login to continue',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text(
                              'Email',
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                    .hasMatch(value)) {
                              return 'Please enter valid email';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            email = value!.trim();
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text(
                              'Password',
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }

                            if (value.length <= 6) {
                              return 'Please enter password of more than 6 characters';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            password = value!.trim();
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: isLoading ? () {} : login,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Login',
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
