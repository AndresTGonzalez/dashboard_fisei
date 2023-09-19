import 'package:dashboard_fisei/utils/security.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  static Future signInWithMail({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'wrong-password') {
        return false;
      }
    }
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static Future testToken() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      String? token = await user.getIdToken();
      printWrapped(token!);
      Security.token = token!;
    } else {}
  }
}
