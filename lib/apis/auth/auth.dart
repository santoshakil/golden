import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

import '../../screens/home/home.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<String> signIn(email, password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      SVProgressHUD.dismiss();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      return 'SignIn Successful';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        SVProgressHUD.dismiss();
        return 'No user found';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        SVProgressHUD.dismiss();
        return 'Wrong password';
      }
      SVProgressHUD.dismiss();
      return 'Something went wrong';
    }
  }

  static Future<String> signUp({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((v) async {
        CollectionReference users =
            FirebaseFirestore.instance.collection('admins');
        User _user = FirebaseAuth.instance.currentUser!;
        users
            .doc(v.user!.uid)
            .set({
              'name': name,
              'email': email,
            })
            .then((_) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        if (!_user.emailVerified) {
          await _user.sendEmailVerification();
        }
      });
      SVProgressHUD.dismiss();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      return 'SignUp Successful';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password is too weak.');
        SVProgressHUD.dismiss();
        return 'The password is too weak';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists.');
        SVProgressHUD.dismiss();
        SVProgressHUD.dismiss();
        return 'The account already exists';
      } else {
        print(e);
        SVProgressHUD.dismiss();
        return e.toString();
      }
    } catch (e) {
      print(e);
      SVProgressHUD.dismiss();
      return 'Something went wrong';
    }
  }

  static Future<void> signOut(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
  }
}
