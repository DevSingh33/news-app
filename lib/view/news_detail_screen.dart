import 'package:assignment_news_app/widgets/custom_appbar.dart';
import 'package:assignment_news_app/models/news_data_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class NewsDetailCard extends StatelessWidget {
  final News news;

  const NewsDetailCard({required this.news, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50), child: CustomAppBar()),
        body: SizedBox(
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        news.imageUrl ??
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black87,
                        Colors.black12,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 250,
                left: 30,
                right: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.description ?? 'description',
                      style: Theme.of(context).textTheme.headline3,
                      maxLines: 5,
                    ),
                    Text(
                      '- ${news.source}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 30,
                right: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          news.source ?? 'source',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          news.publishedDate?.substring(0, 10) ?? 'date',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      news.description ?? 'description',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
