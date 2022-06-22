import 'package:assignment_news_app/models/news_data_model.dart';
import 'package:assignment_news_app/view/news_detail_screen.dart';

import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard({
    required this.news,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsDetailCard(
            news: news,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          //alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.3,
              foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(news.imageUrl ??
                      'https://a1.espncdn.com/combiner/i?img=%2Fphoto%2F2022%2F0619%2Fr1026712_1296x729_16%2D9.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    // stops: [2, 5],
                  )),
            ),
            Positioned(
              top: 140,
              bottom: 20,
              left: 20,
              right: 20,
              child: Text(
                news.title ?? 'title',
                style: Theme.of(context).textTheme.headline6,
                maxLines: 2,
              ),
            ),
            Positioned(
              left: 20,
              bottom: 10,
              child: Row(
                children: [
                  Text(
                    news.source ?? 'source',
                  ),
                  const SizedBox(width: 20),
                  Text(
                    news.publishedDate?.substring(0, 10) ?? 'publishedDate',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
