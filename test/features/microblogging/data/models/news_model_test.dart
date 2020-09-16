import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:grupo_boticario/features/microblogging/data/models/message_model.dart';
import 'package:grupo_boticario/features/microblogging/data/models/news_model.dart';
import 'package:grupo_boticario/features/microblogging/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tUser = UserModel.fromJson({
    'name': 'O Boticário',
    'profile_picture':
        'https://pbs.twimg.com/profile_images/1240676323913347074/Gg09hEPx_400x400.jpg'
  });

  final tMessage = MessageModel.fromJson({
    'content':
        'Além disso, nossos funcionários e familiares receberão kits de proteção. Afinal, o cuidado começa aqui dentro, né?',
    'created_at': '2020-02-02T16:10:33Z'
  });

  final tNewsModel = NewsModel(
    user: tUser,
    message: tMessage,
  );

  test('deve ser uma subclasse de News entity', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('news_response.json'));
    // act
    final result = NewsModel.fromJson(jsonMap['news'][0]);
    // assert
    expect(result, tNewsModel);
  });

  test('deve retornar um JSON contendo os atributos adequados', () async {
    // act
    final result = tNewsModel.toJson();
    // assert
    final expectedJsonMap = {
      "user": {
        "name": "O Boticário",
        "profile_picture":
            "https://pbs.twimg.com/profile_images/1240676323913347074/Gg09hEPx_400x400.jpg"
      },
      "message": {
        "content":
            "Além disso, nossos funcionários e familiares receberão kits de proteção. Afinal, o cuidado começa aqui dentro, né?",
        "created_at": "2020-02-02T16:10:33Z"
      }
    };

    expect(result, expectedJsonMap);
  });
}
