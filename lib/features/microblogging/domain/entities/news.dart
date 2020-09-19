import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/message_model.dart';
import '../../../auth/data/models/user_model.dart';

class News extends Equatable {
  final UserModel user;
  final MessageModel message;

  News({
    @required this.user,
    @required this.message,
  });

  @override
  List<Object> get props => [user, message];
}
