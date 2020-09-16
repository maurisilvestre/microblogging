import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Message extends Equatable {
  final String content;
  final DateTime createdAt;

  Message({
    @required this.content,
    @required this.createdAt,
  });

  @override
  List<Object> get props => [content, createdAt];
}
