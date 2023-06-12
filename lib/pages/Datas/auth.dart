import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future signInFunc(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future signOutFunc() async{
    return await _auth.signOut();
  }

  Future createPerson(String name, String email, String password) async{
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore.collection("Person").doc(user.user?.uid)
        .set({
      'username' : name,
      'email' : email
    });

    return user.user;

  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      var documentSnapshot = await _firestore.collection("Person").doc(userId).get();
      if (documentSnapshot.exists) {
        var userData = documentSnapshot.data();
        return userData as Map<String, dynamic>;
      } else {
        print('Belirtilen kullanıcı bulunamadı.');
        return {};
      }
    } catch (e) {
      print('Hata: $e');
      return {};
    }
  }

  Future signInAnonymously() async {
    var user = await _auth.signInAnonymously();
    return user.user;
  }
}