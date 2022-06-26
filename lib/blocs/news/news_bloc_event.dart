part of 'news_bloc_bloc.dart';

abstract class NewsBlocEvent {}

class InitialNewsEvent extends NewsBlocEvent {}

class FetchNewsFromMemoryEvent extends NewsBlocEvent {}

class FetchNewsFromRepoEvent extends NewsBlocEvent {}

class NewsLoadedEvent extends NewsBlocEvent {}
