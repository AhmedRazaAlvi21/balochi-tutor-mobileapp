import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class socialAuthRepository {
  Future<User?> googleAuth() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
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
