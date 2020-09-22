import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:grupo_boticario/features/auth/data/models/user_model.dart';

// ignore: must_be_immutable
class Comentario extends Equatable {
  DocumentReference reference;
  final String comentario;
  final UserModel userModel;
  final DateTime createdAt;

  Comentario(
      {this.reference,
      @required this.comentario,
      @required this.userModel,
      @required this.createdAt});

  @override
  List<Object> get props => [reference, comentario, userModel, createdAt];
}
