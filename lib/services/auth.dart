import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> anonymousLogin() async {
    final Logger logger = Logger(printer: PrettyPrinter());
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      if (userCredential.user != null) {
        logger.i(
            'Anonymous Login Succeeded: ${userCredential.user!.displayName}');
      }
    } on FirebaseAuthException catch (exception) {
      logger.e('Anonymous Login Failed: ${exception.message}');
      // handle exception
    }
  }

  Future<void> googleLogin() async {
    final Logger logger = Logger(printer: PrettyPrinter());
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);

      if (userCredential.user != null) {
        logger.i('Google Login Succeeded: ${userCredential.user!.displayName}');
      }
    } on FirebaseAuthException catch (exception) {
      logger.e('Google Login Failed: ${exception.message}');
      // handle exception
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
