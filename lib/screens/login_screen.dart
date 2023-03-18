// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dashboard/screens/main_screen.dart';
import 'package:dashboard/widgets/custom_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../services/database_services.dart';
import '../widgets/custom_textbox.dart';
// import '../widgets/my_snackbar.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  // @override
  // State<LoginScreen> createState() => _LoginScreenState();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   // final authService = AuthService();
//   bool _isLoading = false;
//   String email = '';
//   String password = '';

//   void _signin() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       _formKey.currentState!.save();

//       // dynamic value =
//       //     await authService.loginUserWithEmailAndPassword(email, password);

//       // if (value == true) {
//       //   QuerySnapshot snapshot =
//       //       await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
//       //           .getUserDataUsingEmail(email);

//         // await HelperFunction.setAdminEmail(email);

//       //   setState(() {
//       //     _isLoading = false;
//       //   });

//       //   if (mounted) {
//       //     Navigator.of(context).pushNamedAndRemoveUntil(
//       //       MainScreen.routeName,
//       //       (route) => false,
//       //     );
//       //   }
//       // } else {
//       //   setState(() {
//       //     _isLoading = false;
//       //   });

//         // if (mounted) {
//         //   MySnackbar.showSnackbar(context, Color(0XFFFF5252), value);
//         // }
//       }
//     }
//   }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
        child: SingleChildScrollView(
      child: Form(
        // key: _formKey,
        child: Column(
          children: <Widget>[
            CustomTextbox(
              prefixIcon: Icons.email_outlined,
              labelData: 'Email',
              maxLines: 1,
              isHidden: false,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                        .hasMatch(value)) {
                  return 'Please enter valid email';
                }

                return null;
              },
              // onSave: (value) {
              //   email = value!.trim();
              // },
            ),
            const SizedBox(height: 15),
            CustomTextbox(
              prefixIcon: Icons.lock_outline,
              textInputType: TextInputType.text,
              maxLines: 1,
              labelData: 'Password',
              isHidden: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }

                if (value.length <= 6) {
                  return 'Please enter password of more than 6 characters';
                }

                return null;
              },
              // onSave: (value) {
              //   password = value!;
              // },
            ),
            const CustomButton(
              title: 'Login Button',
            ),
          ],
        ),
      ),
    )),
  );
}
