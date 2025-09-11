import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  void login(String email, String password) async{
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw FirebaseAuthException(code: EmailAuthProvider.EMAIL_PASSWORD_SIGN_IN_METHOD);
    }
  }

  void register(String email, String password) async{
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw FirebaseAuthException(code: EmailAuthProvider.EMAIL_PASSWORD_SIGN_IN_METHOD);
    }
  }

  void logout() async{
    try{
      await _auth.signOut();
    } catch(e){
      throw FirebaseAuthException(code: EmailAuthProvider.EMAIL_PASSWORD_SIGN_IN_METHOD);
    }
  }
}