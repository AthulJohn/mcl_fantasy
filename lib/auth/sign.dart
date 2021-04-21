import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mcl_fantasy/Classes/dataClass.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    FireBaseService().addPlayerID(user.email);
    print(user.email);
    if (!user.email.endsWith('mace.ac.in') &&
        user.email != 'johnychackopulickal@gmail.com') {
      signOutGoogle();
      return null;
    }
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      return user;
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

  bool isnotSignedIn() {
    return googleSignIn.currentUser == null;
  }
}
