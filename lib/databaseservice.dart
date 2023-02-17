import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<String?> addUser(
      {required String fullName,
      required String age,
      required String email,
      required shift,
      required startTime,
      required endTime,
      required roomNo,
      required attendance}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      // Call the user's CollectionReference to add a new user
      await users.doc(email).set({
        'full_name': fullName,
        'age': age,
        "shift": shift,
        "startTime": startTime,
        "endTime": endTime,
        "roomNo": roomNo,
        "attendance": attendance
      });
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<dynamic> getUser(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc(email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data;
    } catch (e) {
      return 'Error fetching user';
    }
  }
}
