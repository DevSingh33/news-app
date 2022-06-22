import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:assignment_news_app/blocs/internet/internet_bloc_bloc.dart';
import 'package:assignment_news_app/blocs/news/news_bloc_bloc.dart';
import 'package:assignment_news_app/services/hive_services.dart';
import 'package:assignment_news_app/widgets/news_card.dart';
import 'package:assignment_news_app/models/news_data_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<News> newsArticles = [];

  void getHiveData() async {
    print('getHiveDataCalled()');
    final box = await Hive.openBox<News>(HiveService.hiveBoxName);
    setState(() {
      newsArticles = box.values.toList();
    });
  }

  @override
  void initState() {
    getHiveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  getHiveData();
    debugPrint('whole page build');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'HEADLINES',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 6,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocConsumer<InternetBloc, InternetBlocState>(
        listener: (context, state) {
          if (state is InternetGainedState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Internet Connected',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.lightGreen,
              ),
            );
          } else if (state is InternetLostState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Internet Lost',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Check Your Connection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is InternetLostState || state is InternetInitialState) {
            getHiveData();
            // setState(() {});
            return newsArticles.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                : ListView.builder(
                    itemCount: newsArticles.length,
                    itemBuilder: ((context, index) =>
                        NewsCard(news: newsArticles[index])),
                  );
          }
          return BlocProvider(
            create: (context) {
              return NewsBloc(RepositoryProvider.of(context))
                ..add(FetchNewsEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<NewsBloc, NewsBlocState>(
                builder: (context, state) {
                  if (state is NewsInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellowAccent,
                      ),
                    );
                  }
                  if (state is NewsLoadedState) {
                    return ListView.builder(
                      itemCount: state.newsList.length,
                      itemBuilder: ((context, index) =>
                          NewsCard(news: state.newsList[index])),
                    );
                  }
                  if (state is NewsErrorState) {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
