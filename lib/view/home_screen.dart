import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:assignment_news_app/blocs/internet/internet_bloc_bloc.dart';
import 'package:assignment_news_app/blocs/news/news_bloc_bloc.dart';
import 'package:assignment_news_app/widgets/news_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        builder: (context, internetState) {
          return BlocProvider(
            create: (context) {
              return NewsBloc(RepositoryProvider.of(context))
                ..add(FetchNewsEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<NewsBloc, NewsBlocState>(
                builder: (context, newsState) {
                  if (newsState is NewsInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellowAccent,
                      ),
                    );
                  }
                  if (newsState is NewsLoadedState) {
                    return ListView.builder(
                      itemCount: newsState.newsList.length,
                      itemBuilder: ((context, index) =>
                          NewsCard(news: newsState.newsList[index])),
                    );
                  }
                  if (newsState is NewsErrorState) {
                    return Center(
                      child: Text(newsState.errorMessage.toString()),
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
