abstract class IAuthRepository {
  /// Returns user id on success.
  Future<String> signIn({required String email, required String password});

  Future<void> signOut();

  bool get isAuthenticated;
}
