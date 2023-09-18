import 'package:dashboard_fisei/utils/security.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  static Future signInWithMail({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future createAccount() async {
    try {
      print('estoy aqui');
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'adminredesfisei@uta.edu.ec',
        password: 'AdminRedesFISEI2000',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static Future testToken() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      String? token = await user.getIdToken();
      // printWrapped(token.toString());
      Security.token = token!;
      print('User is signed in!');
    } else {
      print('User is signed out!');
    }
  }
}
