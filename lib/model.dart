import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  void login() async {
    await _googleSignIn.signOut();
    await _googleSignIn.signIn();
    final DocumentReference documentReference = Firestore.instance.document(
        'users/${_googleSignIn.currentUser.email}');
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot documentSnapshot = await transaction.get(documentReference);
      if (documentSnapshot.exists) {
        print('exist');
      } else {
        print('no exist');
      }
    });
  }
}
