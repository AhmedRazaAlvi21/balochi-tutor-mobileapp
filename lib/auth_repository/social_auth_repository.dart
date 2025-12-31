import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class socialAuthRepository {
  Future<User?> googleAuth() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Sign out from previous Google account to force account selection dialog
      // This ensures user gets account selection dialog every time
      await googleSignIn.signOut();

      // Now sign in - this will show account selection dialog
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // If user cancels the account selection, return null
      if (googleUser == null) {
        print('User cancelled Google Sign-In');
        return null;
      }

      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      return user;
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }
}
