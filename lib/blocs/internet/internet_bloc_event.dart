part of 'internet_bloc_bloc.dart';

abstract class InternetBlocEvent {}

class InternetLostEvent extends InternetBlocEvent {}

class InternetGainedEvent extends InternetBlocEvent {}
