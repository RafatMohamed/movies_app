import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/models/user_model.dart';
import 'package:movies_app/core/services/firestore_service.dart';

/// Thrown by [AuthService] with a human-readable message, so UI code
/// never needs to know about Firebase error codes directly.
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  final FirebaseAuth _auth;
  final FirestoreService _firestoreService;

  AuthService({FirebaseAuth? firebaseAuth, FirestoreService? firestoreService})
    : _auth = firebaseAuth ?? FirebaseAuth.instance,
      _firestoreService = firestoreService ?? FirestoreService();

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  /// Creates the Firebase Auth account and a matching `users/{uid}`
  /// Firestore document holding the profile data collected on the
  /// register screen.
  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
    String phone = '',
    int avatarIndex = 0,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Store the display name on the Firebase user profile.
      await credential.user?.updateDisplayName(name.trim());
      await credential.user?.reload();

      final uid = credential.user?.uid;
      if (uid != null) {
        await _firestoreService.upsertUser(
          UserModel(
            uid: uid,
            name: name.trim(),
            email: email.trim(),
            phone: phone.trim(),
            avatarIndex: avatarIndex,
          ),
          isNew: true,
        );
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw AuthException('Google sign in was cancelled.');
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      if (googleAuth?.accessToken == null || googleAuth?.idToken == null) {
        throw AuthException('Failed to get Google authentication tokens.');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        // isNewUser tells us whether to seed createdAt, but merge:true
        // makes this safe to call on every Google sign-in either way.
        final isNew = userCredential.additionalUserInfo?.isNewUser ?? false;
        await _firestoreService.upsertUser(
          UserModel(
            uid: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            moviesID: [],
          ),
          isNew: isNew,
        );
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Failed to sign in with Google. Please try again.');
    }
  }

  /// Fetches the signed-in user's Firestore profile document.
  Future<UserModel?> getCurrentUserData() async {
    final uid = currentUser?.uid;
    if (uid == null) return null;
    return _firestoreService.getUser(uid);
  }

  /// Live stream of the signed-in user's Firestore profile document.
  Stream<UserModel?> watchCurrentUserData() {
    final uid = currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _firestoreService.watchUser(uid);
  }

  /// Updates specific profile fields, e.g. `{'name': 'New Name'}`.
  Future<void> updateUserData(Map<String, dynamic> data) async {
    final uid = currentUser?.uid;
    if (uid == null) {
      throw AuthException('No signed-in user.');
    }
    await _firestoreService.updateUserFields(uid, data);
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = currentUser;
    if (user == null || user.email == null) {
      throw AuthException('No signed-in user.');
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  Future<void> logout() => _auth.signOut();

  /// Deletes both the Firestore profile document and the Firebase Auth
  /// account. Firebase requires a recent sign-in for this to succeed;
  /// callers should catch `requires-recent-login` and re-authenticate.
  Future<void> deleteAccount() async {
    final user = currentUser;
    if (user == null) {
      throw AuthException('No signed-in user.');
    }
    try {
      await _firestoreService.deleteUser(user.uid);
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  String _mapError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'That email address looks invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password is too weak (min 6 characters).';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled for this project.';
      case 'requires-recent-login':
        return 'Please log in again before deleting your account.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
