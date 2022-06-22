part of 'news_bloc_bloc.dart';

abstract class NewsBlocState {}

class NewsInitialState extends NewsBlocState {}

class NewsLoadingState extends NewsBlocState {}

class NewsLoadedState extends NewsBlocState {
  final List<News> newsList;
  NewsLoadedState({required this.newsList});
}

class NewsErrorState extends NewsBlocState {
  final String errorMessage;
  NewsErrorState({required this.errorMessage});
}
