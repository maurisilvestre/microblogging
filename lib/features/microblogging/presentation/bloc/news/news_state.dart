part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class Empty extends NewsState {}

class Loading extends NewsState {}

class Loaded extends NewsState {
  final List<News> news;

  Loaded({@required this.news});
  @override
  List<Object> get props => [news];
}

class Error extends NewsState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
