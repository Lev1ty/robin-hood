import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scoped_model/scoped_model.dart';

enum User { ROBIN, PEOPLE }

class AppModel extends Model {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  final Geolocator _geolocator = Geolocator();

  User _user;

  set user(User user) {
    _user = user;
    Firestore.instance.runTransaction((Transaction transaction) async =>
        await transaction.update(
            Firestore.instance
                .document('users/${_googleSignIn.currentUser.email}'),
            {
              'user': _user.index,
            }));
  }

  void login() async {
    await _googleSignIn.signIn();
    final DocumentReference documentReference =
        Firestore.instance.document('users/${_googleSignIn.currentUser.email}');
    await Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(documentReference);
      if (!documentSnapshot.exists) {
        await transaction.set(documentReference, {
          'firstLogin': FieldValue.serverTimestamp(),
        });
      }
      Position position = await _geolocator.getCurrentPosition();
      await transaction.update(documentReference, {
        'time': FieldValue.serverTimestamp(),
        'location': GeoPoint(position.latitude, position.longitude),
      });
    });
  }
}
