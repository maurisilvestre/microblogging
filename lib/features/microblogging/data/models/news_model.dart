import 'package:flutter/foundation.dart';

import '../../domain/entities/news.dart';
import 'message_model.dart';
import '../../../auth/data/models/user_model.dart';

class NewsModel extends News {
  NewsModel({
    @required UserModel user,
    @required MessageModel message,
  }) : super(
          user: user,
          message: message,
        );

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final user = UserModel.fromJson(json['user']);
    final message = MessageModel.fromJson(json['message']);
    return NewsModel(user: user, message: message);
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJsonNews(), 'message': message.toJson()};
  }
}
