import 'package:injectable/injectable.dart';
import 'package:gegabyteauto/core/error/failures.dart';
import 'package:gegabyteauto/domain/repositories/i_auth_repository.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  bool _isAuthenticated = false;

  @override
  bool get isAuthenticated => _isAuthenticated;

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    // Simulate network request delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // TODO: Replace with real Firebase Auth / API call
    if (email.isEmpty || password.isEmpty) {
      throw const AuthFailure('Email and password cannot be empty.');
    }

    if (password.length < 6) {
      throw const AuthFailure('Password must be at least 6 characters.');
    }

    // Mock: any valid-looking credentials succeed
    _isAuthenticated = true;
    return 'mock_user_id_${email.hashCode}';
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isAuthenticated = false;
  }
}
