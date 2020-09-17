import 'package:flutter/material.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/news.dart';

class NewsDisplay extends StatelessWidget {
  final List<News> news;

  const NewsDisplay({
    Key key,
    @required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        itemCount: news.length,
        itemBuilder: (_, idx) {
          return Text(news[idx].message.content);
        },
      ),
    );
  }
}
