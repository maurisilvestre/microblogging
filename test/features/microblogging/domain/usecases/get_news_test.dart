import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grupo_boticario/core/usecases/usecase.dart';
import 'package:grupo_boticario/features/microblogging/data/models/message_model.dart';
import 'package:grupo_boticario/features/microblogging/data/models/news_model.dart';
import 'package:grupo_boticario/features/microblogging/data/models/user_model.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/message.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/news.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/user.dart';
import 'package:grupo_boticario/features/microblogging/domain/repositories/news_repository.dart';
import 'package:grupo_boticario/features/microblogging/domain/usecases/get_news.dart';
import 'package:mockito/mockito.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  GetNews usecase;
  MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetNews(mockNewsRepository);
  });

  final tUser = UserModel(
    name: 'O Boticário',
    profilePicture:
        'https://pbs.twimg.com/profile_images/1240676323913347074/Gg09hEPx_400x400.jpg',
  );
  final tMessage = MessageModel(
      content:
          'Além disso, nossos funcionários e familiares receberão kits de proteção. Afinal, o cuidado começa aqui dentro, né?',
      createdAt: DateTime.parse("2020-02-02T16:10:33Z"));

  final tNews = [NewsModel(user: tUser, message: tMessage)];

  test('deve buscar uma novidade do repository', () async {
    // arrange
    when(mockNewsRepository.getNews()).thenAnswer((_) async => Right(tNews));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tNews));
    verify(mockNewsRepository.getNews());
    verifyNoMoreInteractions(mockNewsRepository);
  });
}
