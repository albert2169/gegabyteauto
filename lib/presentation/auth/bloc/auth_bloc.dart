import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:gegabyteauto/core/error/failures.dart';
import 'package:gegabyteauto/domain/repositories/i_auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthCheckStatusRequested>(_onCheckStatusRequested);
  }

  Future<void> _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final userId = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(userId: userId));
    } on AuthFailure catch (e) {
      emit(AuthFailureState(message: e.message));
    } on Failure catch (e) {
      emit(AuthFailureState(message: e.message));
    } catch (_) {
      emit(const AuthFailureState(
          message: 'An unexpected error occurred. Please try again.'));
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
    emit(const AuthUnauthenticated());
  }

  Future<void> _onCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (_authRepository.isAuthenticated) {
      emit(const AuthAuthenticated(userId: 'cached_user'));
    } else {
      emit(const AuthUnauthenticated());
    }
  }
}
