import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/core/models/user_model.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authService) : super(const AuthInitial()) {
    _subscription = _authService.authStateChanges.listen((user) {
      emit(user != null ? Authenticated(user) : const Unauthenticated());
    });
  }

  final AuthService _authService;
  late final StreamSubscription<User?> _subscription;

  /// Quick synchronous access to the current user without needing to
  /// pattern-match on the state. Null if signed out or not yet known.
  User? get currentUser {
    final state = this.state;
    return state is Authenticated ? state.user : null;
  }

  Future<void> signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout()async {
    await _authService.logout();
    await GoogleSignIn().signOut();
  }

  /// Sends a password reset email to the provided address.
  Future<void> resetPassword(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
    } catch (e) {
      // Rethrow or handle exception so UI can catch it and show a message
      rethrow;
    }
  }

  Future<UserModel?> getCurrentUserData() {
    return _authService.getCurrentUserData();
  }

  Stream<UserModel?> watchCurrentUserData() {
    return _authService.watchCurrentUserData();
  }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    try {
      await _authService.updateUserData(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reauthenticate(String password) async {
    try {
      await _authService.reauthenticate(password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reauthenticateWithGoogle() async {
    try {
      await _authService.reauthenticateWithGoogle();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _authService.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _authService.deleteAccount();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
