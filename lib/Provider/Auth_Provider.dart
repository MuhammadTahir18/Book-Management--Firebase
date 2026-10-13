import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  User? get currentUser => _auth.currentUser;
  bool _isConfirmPasswordHidden = true;
  bool get isConfirmPasswordHidden => _isConfirmPasswordHidden;

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
    notifyListeners();
  }


  // SIGN UP

  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);

      debugPrint('Signup Error: ${e.code}');

      return false;
    } catch (e) {
      _setLoading(false);

      debugPrint('Signup Error: $e');

      return false;
    }
  }
  // LOGIN
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      _setLoading(false);

      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);

      debugPrint('Login Error: ${e.code}');

      return false;
    } catch (e) {
      _setLoading(false);

      debugPrint('Login Error: $e');

      return false;
    }
  }


  // LOGOUT


  Future<void> logout() async {
    await _auth.signOut();
  }


  // LOADING


  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}