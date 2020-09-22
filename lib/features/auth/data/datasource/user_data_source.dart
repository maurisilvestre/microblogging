import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grupo_boticario/core/error/exceptions.dart';
import 'package:grupo_boticario/features/auth/data/models/user_model.dart';

abstract class UserDataSource {
  Future<UserModel> getUser({UserModel userModel});
  Future<UserModel> setUser({UserModel userModel});
}

class UserDataSourceImpl implements UserDataSource {
  @override
  Future<UserModel> getUser({UserModel userModel}) async {
    try {
      DocumentSnapshot documentSnapshot = await userModel.reference.get();
      return UserModel.fromJson(documentSnapshot.data);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> setUser({UserModel userModel}) async {
    try {
      await userModel.reference.setData(userModel.toJson());
      DocumentSnapshot documentSnapshot = await userModel.reference.get();
      return UserModel.fromJson(documentSnapshot.data);
    } catch (e) {
      throw ServerException();
    }
  }
}
