import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/core/const.dart';
import 'package:movies_app/core/models/user_model.dart';

/// Wraps all reads/writes to the `users` Firestore collection so the rest
/// of the app never talks to `cloud_firestore` directly.
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get usersRef =>
      _firestore.collection(AppConstFirestore.usersCollection);

  /// Creates (or merges into) the user's document. Safe to call on both
  /// email/password register and first-time Google sign-in.
  Future<void> upsertUser(UserModel user, {bool isNew = false}) async {
    await usersRef
        .doc(user.uid)
        .set(user.toMap(isNew: isNew), SetOptions(merge: true));
  }

  Future<UserModel?> getUser(String uid) async {
    final snapshot = await usersRef.doc(uid).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return UserModel.fromMap(snapshot.data()!, snapshot.id);
  }

  /// Live-updates whenever the user's document changes.
  Stream<UserModel?> watchUser(String uid) {
    return usersRef.doc(uid).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return UserModel.fromMap(snapshot.data()!, snapshot.id);
    });
  }

  Future<void> updateUserFields(String uid, Map<String, dynamic> data) async {
    await usersRef.doc(uid).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteUser(String uid) async {
    await usersRef.doc(uid).delete();
  }
}
