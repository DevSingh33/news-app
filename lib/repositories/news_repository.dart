import 'package:dio/dio.dart';

import 'package:assignment_news_app/consts.dart';
import 'package:assignment_news_app/models/news_data_model.dart';

class NewsRepository {
  Future<List<News>> getNews() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$ApiKey',
      );
      late final List<News> articleList;
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> decodedData = (response.data);
        List articlesList = decodedData['articles'];
        List<News> newsList =
            articlesList.map((article) => News.fromJson(article)).toList();

        articleList = newsList;
      }
      return articleList;
    } catch (e) {
      rethrow;
    }
  }
}
