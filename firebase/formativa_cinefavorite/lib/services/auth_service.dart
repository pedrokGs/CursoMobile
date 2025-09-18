import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> login(String email, String password) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credentials;
    } on FirebaseAuthException{
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred during login.');
    }
  }

  // Same improved error handling for the register method
  Future<UserCredential?> register(String email, String password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credentials;
    } on FirebaseAuthException{
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred during registration.');
    }
  }

  void logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred during logout.');
    }
  }
}