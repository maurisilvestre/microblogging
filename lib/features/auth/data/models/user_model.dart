import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/user.dart';

// ignore: must_be_immutable
class UserModel extends User {
  UserModel({
    @required DocumentReference reference,
    @required String displayName,
    @required String photoURL,
    @required String email,
  }) : super(
          reference: reference,
          displayName: displayName,
          photoURL: photoURL,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        reference: null,
        displayName: json['name'],
        photoURL: json['profile_picture'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'name': displayName, 'profile_picture': photoURL, 'email': email};
  }

  Map<String, dynamic> toJsonNews() {
    return {
      'name': displayName,
      'profile_picture': photoURL,
    };
  }
}
