import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

String name;
String email;
String uid;
String imageUrl;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
    
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);
  name = user.displayName;
  email = user.email;
  uid = user.uid;
  imageUrl = user.photoUrl;

  // insert user
  
  Map<String, String> userdb = {'username': name, 'useremail': email, 'userId': uid};
  Firestore.instance.collection('user').document(uid).setData(userdb);
  
  // end insert user

  if (name.contains("  ")) {
   name = name.substring(0, name.indexOf("  "));
  }

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

Future<String> getCurrentUID() async {
  return (await _auth.currentUser()).uid;
}

void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out");
}