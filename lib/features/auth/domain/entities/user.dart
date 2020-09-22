import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  DocumentReference reference;
  final String displayName;
  final String photoURL;
  final String email;

  User({
    @required this.reference,
    @required this.displayName,
    @required this.photoURL,
    @required this.email,
  });

  @override
  List<Object> get props => [reference, displayName, photoURL, email];
}
