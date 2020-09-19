import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

abstract class AuthDataSource {
  /// Autentica um usuário usando e-mail e senha pelo Firebase Auth
  Future<UserModel> authEmailPassword({String email, String password});

  /// Autentica um usuário usando Google provider pelo Firebase Auth
  Future<UserModel> authGoogleSignIn();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth auth;
  // FirebaseUser user;
  final GoogleSignIn googleSignIn;

  AuthDataSourceImpl(
      //@required this.user,
      {@required this.auth,
      @required this.googleSignIn});

  @override
  Future<UserModel> authEmailPassword({
    String email,
    String password,
  }) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      // user = result.user;

      Map<String, dynamic> _usuarioAutenticado = {
        'name': result.user.displayName,
        'profile_picture': result.user.photoUrl,
        'email': result.user.email,
      };

      return UserModel.fromJson(_usuarioAutenticado);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel> authGoogleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential);

      Map<String, dynamic> _usuarioAutenticado = {
        'name': googleSignIn.currentUser.displayName,
        'profile_picture': googleSignIn.currentUser.photoUrl,
        'email': googleSignIn.currentUser.email,
      };

      return UserModel.fromJson(_usuarioAutenticado);
    } catch (e) {
      return null;
    }
  }
}
