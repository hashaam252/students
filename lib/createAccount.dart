import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:students/databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:students/homescreen.dart';
import 'package:students/login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: const InputDecoration(
                    hintText: 'Age',
                  ),
                ),
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
                  registerUser();
                },
                child: const Text('Create Account'),
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
                      builder: (context) => LoginAccount(
                          // email: _emailController.text,
                          )));
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  registerUser() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("my all users: ${allData.length}");
    if (allData.length > 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sorry session is full!"),
        ),
      );
    } else {
      try {
        EasyLoading.show();
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: "${_emailController.text.trim()}",
                password: "${_passwordController.text.trim()}")
            .whenComplete(() async {
          final result;
          if (allData.length <= 10) {
            result = await DatabaseService().addUser(
                fullName: _nameController.text.trim(),
                age: _ageController.text.trim(),
                email: _emailController.text.trim(),
                shift: "morning",
                startTime: "10 am",
                endTime: "2 pm",
                roomNo: "1",
                attendance: "full");
            if (result!.contains('success')) {
              EasyLoading.dismiss();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Home(
                        email: _emailController.text.trim(),
                      )));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result),
                ),
              );
            } else {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result),
                ),
              );
            }
          } else if (allData.length > 10 && allData.length <= 20) {
            result = await DatabaseService().addUser(
                fullName: _nameController.text,
                age: _ageController.text,
                email: _emailController.text.trim(),
                shift: "Noon",
                startTime: "3 pm",
                endTime: "7 pm",
                roomNo: "2",
                attendance: "full");
            if (result!.contains('success')) {
              EasyLoading.dismiss();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Home(
                        email: _emailController.text.trim(),
                      )));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result),
                ),
              );
            } else {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result),
                ),
              );
            }
          } else if (allData.length > 20 && allData.length <= 30) {
            result = await DatabaseService().addUser(
                fullName: _nameController.text,
                age: _ageController.text,
                email: _emailController.text.trim(),
                shift: "Night",
                startTime: "8 pm",
                endTime: "12 pm",
                roomNo: "3",
                attendance: "full");
            if (result!.contains('success')) {
              EasyLoading.dismiss();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Home(
                        email: _emailController.text.trim(),
                      )));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result),
                ),
              );
            } else {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Sorry session is full!"),
              ),
            );
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
