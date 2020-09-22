import 'package:flutter/material.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/news.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class NewsDisplay extends StatefulWidget {
  final List<News> news;

  const NewsDisplay({
    Key key,
    @required this.news,
  }) : super(key: key);

  @override
  _NewsDisplayState createState() => _NewsDisplayState();
}

class _NewsDisplayState extends State<NewsDisplay> {
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        // separatorBuilder: (context, index) => Divider(),
        itemCount: widget.news.length,
        itemBuilder: (_, idx) {
          return Card(
            elevation: 0,
            child: ListTile(
              isThreeLine: true,
              leading: Icon(
                Icons.person,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                widget.news[idx].message.content,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.news[idx].user.displayName,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat('EEE, d MMM yyyy', 'pt_BR')
                          .format(widget.news[idx].message.createdAt),
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
