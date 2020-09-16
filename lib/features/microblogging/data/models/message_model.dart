import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    @required String content,
    @required DateTime createdAt,
  }) : super(
          content: content,
          createdAt: createdAt,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        content: json['content'],
        createdAt: DateTime.parse(json['created_at']));
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'created_at': convertDateTime(createdAt.toIso8601String())
    };
  }
}

String convertDateTime(String date) {
  return DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.parse(date)) + 'Z';
}
