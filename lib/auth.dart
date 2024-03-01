import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }
}
