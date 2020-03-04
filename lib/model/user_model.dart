import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData;
  bool isLoading = false;

  @override
  Future<void> addListener(listener) async {
    super.addListener(listener);

    await _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    await _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((user) async {
      firebaseUser = user;
      await _saveUserData(userData);

      isLoading = false;
      notifyListeners();
      onSuccess();
    }).catchError((err) {
      print(err);

      isLoading = false;
      notifyListeners();
      onFail();
    });
  }

  Future<void> signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    try {
      firebaseUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _saveUserData(userData);

      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      onFail();
    }

    isLoading = false;
    notifyListeners();
  }

  bool isLogged() {
    return firebaseUser != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    firebaseUser = null;
    userData = Map();
    notifyListeners();
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<void> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (userData == null) {
      userData = await feedUserData();
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> feedUserData() async {
    DocumentSnapshot doc = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .get();
    return doc.data;
  }

  void resetPassword(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }
}
