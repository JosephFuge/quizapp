import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider((ref) => auth.FirebaseAuth.instance);
final firebaseFirestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final appInitProvider = FutureProvider((ref) async {
  try {
    await Firebase.initializeApp();

    // await FlutterBranchSdk.init();
  } catch (error) {
    debugPrint(error.toString());
  }
});

// final _firebaseInitProvider = FutureProvider((ref) async {
//   try {
//     await ref.read(_firebaseInitProvider.future);
//   } catch (error) {
//     debugPrint(error.toString());
//   }
// });
