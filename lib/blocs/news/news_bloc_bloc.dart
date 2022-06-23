import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc/bloc.dart';

import 'package:assignment_news_app/services/hive_services.dart';
import 'package:assignment_news_app/models/news_data_model.dart';
import 'package:assignment_news_app/repositories/news_repository.dart';

part 'news_bloc_event.dart';
part 'news_bloc_state.dart';

class NewsBloc extends Bloc<NewsBlocEvent, NewsBlocState> {
  final NewsRepository _newsRepository;

  NewsBloc(
    this._newsRepository,
  ) : super(NewsInitialState()) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final hive = HiveService();
        final box = await Hive.openBox<News>(HiveService.hiveBoxName);
        hive.getDataFromHive();

        if (box.isNotEmpty) {
          emit(NewsLoadedState(newsList: box.values.toList()));
        } else {
          final List<News> newsList = await _newsRepository.getNews();
          box.clear();
          hive.addDataToHive(newsList);
          emit(NewsLoadedState(newsList: newsList));
        }
      } catch (e) {
        emit(NewsErrorState(errorMessage: e.toString()));
      }
    });
  }
}
