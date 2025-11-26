import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  static Stream<List<BlinkUser>> getNearbyUsers() {
    return _db
        .collection('users')
        .where('isInvisible', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BlinkUser(
                  uid: doc.id,
                  name: doc['name'],
                  city: doc['city'],
                  photoUrl: doc['photoUrl'],
                  isInvisible: doc['isInvisible'],
                  socialLinks: Map<String, String>.from(doc['socialLinks'] ?? {}),
                  latitude: doc['latitude'],
                  longitude: doc['longitude'],
                ))
            .toList());
  }

  static Future<void> updateVisibility(bool visible) async {
    await _db.collection('users').doc(currentUser!.uid).update({'isInvisible': !visible});
  }

  static Future<void> signOut() => _auth.signOut();
}