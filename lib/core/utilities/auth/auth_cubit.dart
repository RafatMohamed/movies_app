import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'auth_state.dart';

/// Single source of truth for "who is logged in right now".
///
/// Registered once in GetIt (see get_it.dart) and provided at the root of
/// the widget tree, so any teammate can do:
///
///   context.read<AuthCubit>().currentUser   // one-off read
///   context.watch<AuthCubit>().state        // rebuilds on change
///   BlocBuilder<AuthCubit, AuthState>(...)  // reactive UI
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

  Future<void> logout() => _authService.logout();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}