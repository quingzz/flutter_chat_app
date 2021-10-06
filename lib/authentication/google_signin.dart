import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_flutter_app/widgets/sidebar.dart';

class GoogleAuth {
  // initialize database ref
  static final _databaseRef = FirebaseDatabase.instance.reference();

  static Future<User?> signInWithGoogle() async {
    // trigger log in with google process
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // user authenticate with their accout
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // get the account credentials
    final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    // login to firebase using given credentials
    final UserCredential userCred =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCred.user;

    // Make sure that the user instance is not anonymous
    assert(!user!.isAnonymous);

    // get logged in user info
    final userName = user!.displayName;
    final userId = user.uid;
    final userImg = user.photoURL;

    // add/update user info to database
    final _userRef = _databaseRef.child('user/$userId');
    _userRef.set({'name': userName, 'img': userImg});
  }

  static Future<void> signOut() async {
    // signout with google_sign_in package
    await GoogleSignIn().signOut();
    // signout with firebase auth instance
    await FirebaseAuth.instance.signOut();
  }
}
