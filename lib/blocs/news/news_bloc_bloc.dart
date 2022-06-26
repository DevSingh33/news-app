import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc/bloc.dart';

import 'package:assignment_news_app/services/hive_services.dart';
import 'package:assignment_news_app/models/news_data_model.dart';
import 'package:assignment_news_app/repositories/news_repository.dart';

part 'news_bloc_event.dart';
part 'news_bloc_state.dart';

class NewsBloc extends Bloc<NewsBlocEvent, NewsBlocState> {
  final NewsRepository _newsRepository;

  NewsBloc(this._newsRepository) : super(NewsInitialState()) {
    on<FetchNewsFromMemoryEvent>(
      (event, emit) async {
        emit(NewsLoadingState());
        try {
          final box = await Hive.openBox<News>(HiveService.hiveBoxName);

          if (box.isNotEmpty) {
            emit(NewsLoadedState(newsList: box.values.toList()));
          } else if (box.isEmpty) {
            emit(
              NewsErrorState(
                  errorMessage:
                      'First Time App Opened?, Check Your Connection'),
            );
          }
        } catch (e) {
          emit(NewsErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<FetchNewsFromRepoEvent>(
      (event, emit) async {
        emit(NewsLoadingState());
        try {
          var hive = HiveService();
          final box = await Hive.openBox<News>(HiveService.hiveBoxName);
          final List<News> newsList = await _newsRepository.getNews();
          box.clear();
          hive.addDataToHive(newsList);

          emit(NewsLoadedState(newsList: newsList));
        } catch (e) {
          emit(NewsErrorState(errorMessage: e.toString()));
        }
      },
    );
  }
}
