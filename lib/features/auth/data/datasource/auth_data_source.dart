import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grupo_boticario/features/auth/data/datasource/user_data_source.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthDataSource {
  /// Autentica um usuário usando e-mail e senha pelo Firebase Auth
  Future<UserModel> authEmailPassword({
    UserModel userModel,
    String email,
    String password,
  });

  /// Autentica um usuário usando Google provider pelo Firebase Auth
  Future<UserModel> authGoogleSignIn();

  /// Busca o usuário logado
  Future<UserModel> authCurrentUser();

  /// Desloga o usuário
  Future<UserModel> authLogOut();

  /// Registra o usuário utilizando email e senha
  Future<UserModel> authRegisterEmailPassword({
    UserModel userModel,
    String email,
    String password,
  });

  Future<UserModel> getUsuario({String id});
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth auth;
  dynamic user;
  UserDataSourceImpl userDataSource;
  final GoogleSignIn googleSignIn;

  AuthDataSourceImpl(
      //@required this.user,
      {@required this.auth,
      @required this.googleSignIn});

  @override
  Future<UserModel> authEmailPassword({
    UserModel userModel,
    String email,
    String password,
  }) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return await getUsuario(id: result.user.uid);

      // UserModel _userModel = UserModel(
      //     reference: Firestore.instance
      //         .collection('usuario')
      //         .document(result.user.uid),
      //     displayName: null,
      //     photoURL: null,
      //     email: null);
      // userDataSource = UserDataSourceImpl();
      // return userDataSource.getUser(userModel: _userModel);
    } catch (e) {
      throw ServerException();
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
      user = googleSignIn.currentUser;

      Map<String, dynamic> _usuarioAutenticado = {
        'name': user.displayName,
        'profile_picture': user.photoUrl,
        'email': user.email,
      };

      Firestore.instance
          .collection('usuario')
          .document(googleSignIn.currentUser.id)
          .setData(_usuarioAutenticado);

      return UserModel.fromJson(_usuarioAutenticado);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> authCurrentUser() async {
    try {
      user = await auth.currentUser();
      Map<String, dynamic> _usuarioAutenticado = {
        'name': user.displayName,
        'profile_picture': user.photoUrl,
        'email': user.email,
      };

      return await getUsuario(id: user.uid);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> authLogOut() async {
    try {
      await auth.signOut();
      return UserModel(
          displayName: null, photoURL: null, email: null, reference: null);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> authRegisterEmailPassword({
    UserModel userModel,
    String email,
    String password,
  }) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      userDataSource = UserDataSourceImpl();

      if (userModel != null) {
        userModel.reference =
            Firestore.instance.collection('usuario').document(result.user.uid);
        userDataSource.setUser(userModel: userModel);
      }

      return userModel;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUsuario({String id}) async {
    try {
      DocumentSnapshot ref =
          await Firestore.instance.collection('usuario').document(id).get();

      UserModel userModel = UserModel.fromJson(ref.data);
      userModel.reference = ref.reference;

      return userModel;
    } catch (e) {
      throw ServerException();
    }
  }
}
