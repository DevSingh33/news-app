part of 'news_bloc_bloc.dart';

abstract class NewsBlocEvent {}

class FetchNewsEvent extends NewsBlocEvent {}

class InitialNewsEvent extends NewsBlocEvent {}
