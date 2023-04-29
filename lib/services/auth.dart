import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> anonymousLogin() async {
    final Logger logger = Logger(printer: PrettyPrinter());
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      logger.e('Anonymous Login Succeeded: ${userCredential.user}');
    } on FirebaseAuthException catch (exception) {
      logger.e('Anonymous Login Failed: ${exception.message}');
      // handle exception
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
