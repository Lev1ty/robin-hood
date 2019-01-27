import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scoped_model/scoped_model.dart';

enum User { ROBIN, PEOPLE }
enum Category { FOOD }

class AppModel extends Model {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  User _user;
  DocumentReference _documentReference;

  set user(User user) {
    _user = user;
    _documentReference.updateData({
      'user': _user.index,
    });
  }

  void login() async {
    await _googleSignIn.signIn();
    _documentReference =
        Firestore.instance.document('users/${_googleSignIn.currentUser.email}');
    Position position = await Geolocator().getCurrentPosition();
    _documentReference.setData({
      'time': FieldValue.serverTimestamp(),
      'location': GeoPoint(position.latitude, position.longitude),
    });
  }

  void donate(Category category) async {
    Position position = await Geolocator().getCurrentPosition();
    Firestore.instance.collection('donations').document().setData(
      {
        'user': _documentReference,
        'amount': 100,
        'location': GeoPoint(position.latitude, position.longitude),
        'time': FieldValue.serverTimestamp(),
        'category': category.index,
      },
    );
  }

  void withdrawl(num amount, Category category) async {
    Position position = await Geolocator().getCurrentPosition();
    List<DocumentSnapshot> documentSnapshots = (await Firestore.instance
            .collection('donations')
            .where('category', isEqualTo: category.index)
            .orderBy('time')
            .getDocuments())
        .documents
      ..sort((DocumentSnapshot a, DocumentSnapshot b) {
        return sqrt(pow((a.data['location'].longitude - position.longitude),
                        2) +
                    pow((a.data['location'].latitude - position.latitude), 2)) <
                sqrt(pow((b.data['location'].longitude - position.longitude),
                        2) +
                    pow((b.data['location'].latitude - position.latitude), 2))
            ? -1
            : 1;
      });
    num balance = amount;
    for (int i = 0; i < documentSnapshots.length && balance != 0; i++) {
      num amount = documentSnapshots[i].data['amount'];
      DocumentReference documentReference = documentSnapshots[i].reference;
      Position position = await Geolocator().getCurrentPosition();
      DocumentReference donationHistoryDocumentReference =
          Firestore.instance.collection('donationHistory').document()
            ..setData({
              'donator': documentSnapshots[i].data['user'],
              'locationDonated': documentSnapshots[i].data['location'],
              'timeDonated': documentSnapshots[i].data['time'],
              'receiver': _documentReference,
              'locationReceived':
                  GeoPoint(position.latitude, position.longitude),
              'timeReceived': FieldValue.serverTimestamp(),
              'category': documentSnapshots[i].data['category'],
            });
      if (balance >= amount) {
        balance -= amount;
        donationHistoryDocumentReference.updateData({
          'amount': amount,
        });
        documentReference.delete();
      } else {
        donationHistoryDocumentReference.updateData({
          'amount': balance,
        });
        documentReference.updateData({'amount': amount - balance});
        balance = 0;
      }
    }
  }

  Stream<QuerySnapshot> get donationHistory {
    return Firestore.instance
        .collection('donationHistory')
        .where('donator', isEqualTo: _documentReference)
        .snapshots();
  }

  Stream<QuerySnapshot> get receiverHistory {
    return Firestore.instance
        .collection('donationHistory')
        .where('receiver', isEqualTo: _documentReference)
        .snapshots();
  }

  num amountByCategory(
      Category category, AsyncSnapshot<QuerySnapshot> snapshot) {
    return (snapshot.data.documents
            .where((DocumentSnapshot documentSnapshot) =>
                documentSnapshot['category'] == category.index)
            .map((DocumentSnapshot documentSnapshot) =>
                documentSnapshot['amount'])
            .reduce((a, b) => a + b) as int)
        .toDouble();
  }

  num count(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .where((DocumentSnapshot documentSnapshot) =>
            documentSnapshot['donator'] == _documentReference)
        .toList()
        .length;
  }

  num countReceiver(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .where((DocumentSnapshot documentSnapshot) =>
    documentSnapshot['receiver'] == _documentReference)
        .toList()
        .length;
  }
}
