import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:students/databaseservice.dart';
import 'package:students/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    data = (await DatabaseService().getUser(widget.email))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginAccount(
                        // email: _emailController.text,
                        )));
              });
            },
            child: Icon(
              Icons.logout,
              size: 25,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name'),
                Text('Room No'),
                Text('Start Time'),
                Text('End Time'),
                Text('Shift'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 2, child: Text('${data['full_name']}')),
                Flexible(flex: 3, child: Text('${data['roomNo']}')),
                Flexible(flex: 1, child: Text('${data['startTime']}')),
                Flexible(flex: 1, child: Text('${data['endTime']}')),
                Text('${data['shift']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
