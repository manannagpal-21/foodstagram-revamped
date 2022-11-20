// ignore_for_file: unused_field, unused_import, avoid_print, unused_local_variable, unnecessary_null_comparison

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instabot/models/user.dart' as model;
import 'package:instabot/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.UserModel> getUserdetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    return model.UserModel.fromsnap(snap);
  }

  Future<String> signupMethod({
    // Future signupMethod({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file,
  }) async {
    String res = 'Some Error Occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        // Seeking photo url from uploadimage
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        print(photoUrl);

        model.UserModel user = model.UserModel(
          username: username,
          uid: cred.user!.uid,
          bio: bio,
          photoUrl: photoUrl,
          email: email,
          followers: [],
          following: [],
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        return res = "success";
      } else {
        res = 'One of the field Is empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> logininUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error Occured in login';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Enter Credentials';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
