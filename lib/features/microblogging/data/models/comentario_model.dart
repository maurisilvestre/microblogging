import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/features/auth/data/models/user_model.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/comentario.dart';

// ignore: must_be_immutable
class ComentarioModel extends Comentario {
  ComentarioModel({
    @required DocumentReference reference,
    @required String comentario,
    @required UserModel userModel,
    @required DateTime createdAt,
  }) : super(
          reference: reference,
          comentario: comentario,
          userModel: userModel,
          createdAt: createdAt,
        );

  factory ComentarioModel.fromJson(Map<String, dynamic> jsonMap) {
    UserModel userModel =
        UserModel.fromJson(Map<String, dynamic>.from(jsonMap['userModel']));

    return ComentarioModel(
        reference: null,
        comentario: jsonMap['comentario'],
        userModel: userModel,
        createdAt: jsonMap['created_at'].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'comentario': comentario,
      'userModel': userModel.toJson(),
      'created_at': createdAt
    };
  }
}
