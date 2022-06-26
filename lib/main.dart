import 'dart:io';

import 'package:assignment_news_app/blocs/news/news_bloc_bloc.dart';
import 'package:assignment_news_app/repositories/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:assignment_news_app/blocs/internet/internet_bloc_bloc.dart';
import 'package:assignment_news_app/models/news_data_model.dart';
import 'package:assignment_news_app/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.init(directory.path);
  Hive.registerAdapter<News>(NewsAdapter());
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // HiveService().getDataFromHive();
    return BlocProvider(
      create: (context) => InternetBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          return ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(600, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(700, name: TABLET),
              const ResponsiveBreakpoint.resize(800, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(1700, name: "4K"),
            ],
          );
        },
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          // primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(color: Colors.black87),
          primaryColor: Colors.grey,
          canvasColor: Colors.grey[700],
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white.withOpacity(0.7)),
            bodyText2: TextStyle(color: Colors.white.withOpacity(0.8)),
            headline6: TextStyle(color: Colors.white.withOpacity(0.9)),
            headline3: TextStyle(color: Colors.white.withOpacity(0.9)),
            subtitle2: TextStyle(color: Colors.white.withOpacity(0.4)),
            caption: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ),
        // home: const MyHomePage(),

        home: BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(NewsRepository()),
          child: const MyHomePage(),
        ),
      ),
    );
  }
}
