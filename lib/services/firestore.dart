import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/providers/general_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/services/models.dart';

final firestoreServiceProvider = Provider((ref) => FirestoreService(ref));

class FirestoreService {
  FirestoreService(ProviderRef ref) {
    _db = ref.watch(firebaseFirestoreProvider);
  }

  late FirebaseFirestore _db;

  Future<List<Topic>> getTopics() async {
    final ref = _db.collection('topics');
    final snapshot = await ref.get();
    final data = snapshot.docs.map((s) => s.data());
    final topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  Future<Quiz> getQuiz(String quizId) async {
    final ref = _db.collection('quizzes').doc(quizId);
    final snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        final ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }

  Future<void> updateUserReport(Quiz quiz) {
    final user = AuthService().user!;
    final ref = _db.collection('reports').doc(user.uid);

    final data = {
      'total': FieldValue.increment(1),
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id]),
      }
    };

    return ref.set(data, SetOptions(merge: true));
  }
}
