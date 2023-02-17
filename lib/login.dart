import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:students/createAccount.dart';
import 'package:students/databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:students/homescreen.dart';

class LoginAccount extends StatefulWidget {
  // const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<LoginAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  // final message = await AuthService().registration(
                  //   email: _emailController.text,
                  //   password: _passwordController.text,
                  // );
                  // if (message!.contains('Success')) {

                  // }
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(message),
                  //   ),
                  // );
                  if (_emailController.text.trim().isEmpty ||
                      _passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter your email and password!"),
                      ),
                    );
                  } else {
                    loginUser();
                  }
                },
                child: const Text('Login'),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  // final message = await AuthService().registration(
                  //   email: _emailController.text,
                  //   password: _passwordController.text,
                  // );
                  // if (message!.contains('Success')) {

                  // }
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(message),
                  //   ),
                  // );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => CreateAccount(
                          // email: _emailController.text,
                          )));
                },
                child: const Text('Create An Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginUser() async {
    print("calling login");
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        EasyLoading.dismiss();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Home(
                  email: _emailController.text.trim(),
                )));
      });
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      print("firebase auth exception: ${e.message}");

      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No User Found"),
          ),
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Wrond Password"),
          ),
        );
        print('Wrong password provided for that user.');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${e.message}"),
          ),
        );
      }
    } catch (error) {
      print("Catch error; $error");
    }

    // try {
    //   EasyLoading.show();
    //   UserCredential userCredential = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(
    //           email: "${_emailController.text.trim()}",
    //           password: "${_passwordController.text.trim()}")
    //       .whenComplete(() async {
    //     final result = await DatabaseService().addUser(
    //       fullName: _nameController.text,
    //       age: _ageController.text,
    //       email: _emailController.text,
    //     );
    //     if (result!.contains('success')) {
    //       EasyLoading.dismiss();
    //       Navigator.of(context).pushReplacement(MaterialPageRoute(
    //           builder: (context) => Home(
    //                 email: _emailController.text,
    //               )));
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text(result),
    //         ),
    //       );
    //     } else {
    //       EasyLoading.dismiss();
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text(result),
    //         ),
    //       );
    //     }
    //   });
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //   }
    // }
  }
}
