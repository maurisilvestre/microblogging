import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String name;
  final String profilePicture;

  User({
    @required this.name,
    @required this.profilePicture,
  });

  @override
  List<Object> get props => [name, profilePicture];
}
