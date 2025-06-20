import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user
  Future<String> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        return 'Registration failed. Please try again.';
      }

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'favorites': [],
      });

      return 'Registration successful!';
    } on FirebaseAuthException catch (e) {
      print('Firebase registration error: ${e.code} - ${e.message}');
      return e.message ?? 'Registration failed.';
    } catch (e) {
      print('Unknown registration error: $e');
      return 'Registration failed.';
    }
  }

  // Sign in
  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Login successful!';
    } on FirebaseAuthException catch (e) {
      print('Sign in error: ${e.code} - ${e.message}');
      return e.message ?? 'Login failed.';
    } catch (e) {
      print('Unknown sign in error: $e');
      return 'Login failed.';
    }
  }

  // Reset password
  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent!';
    } on FirebaseAuthException catch (e) {
      print('Reset password error: ${e.code} - ${e.message}');
      return e.message ?? 'Password reset failed.';
    } catch (e) {
      print('Unknown reset password error: $e');
      return 'Password reset failed.';
    }
  }

  // Save a favorite recipe
  Future<void> saveFavorite(String recipeName) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'favorites': FieldValue.arrayUnion([recipeName]),
      });
    }
  }

  // Get all favorites
  Stream<List<String>> getFavorites() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('users').doc(user.uid).snapshots().map((
        snapshot,
      ) {
        final data = snapshot.data();
        if (data != null && data['favorites'] != null) {
          return List<String>.from(data['favorites']);
        } else {
          return [];
        }
      });
    } else {
      return Stream.value([]);
    }
  }
}
