import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

/// Represents whether we know a user yet, and who they are if so.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Firebase hasn't reported the auth state yet (app just started).
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// A user is signed in. Every teammate can grab `state.user` off this.
class Authenticated extends AuthState {
  const Authenticated(this.user);
  final User user;

  @override
  List<Object?> get props => [user.uid];
}

/// No user is signed in.
class Unauthenticated extends AuthState {
  const Unauthenticated();
}