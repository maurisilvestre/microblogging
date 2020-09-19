import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String displayName;
  final String photoURL;
  final String email;

  User({
    @required this.displayName,
    @required this.photoURL,
    @required this.email,
  });

  @override
  List<Object> get props => [displayName, photoURL, email];
}
