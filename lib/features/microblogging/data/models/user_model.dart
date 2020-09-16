import 'package:flutter/foundation.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    @required String name,
    @required String profilePicture,
  }) : super(
          name: name,
          profilePicture: profilePicture,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'], profilePicture: json['profile_picture']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'profile_picture': profilePicture};
  }
}
