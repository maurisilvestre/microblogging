import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../auth/data/models/user_model.dart';
import '../bloc/news/news_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/news_display.dart';
import 'comentarios_page.dart';
import 'perfil_page.dart';

class NewsPage extends StatefulWidget {
  final UserModel userModel;

  const NewsPage({Key key, @required this.userModel}) : super(key: key);
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _currentIndex = 1;
  String _currentPageTitle;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        _currentPageTitle = 'Perfil';
        break;
      case 1:
        _currentPageTitle = 'Microblogging';
        break;
      case 2:
        _currentPageTitle = 'Novidades';
        break;
      default:
        _currentPageTitle = 'Microblogging';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPageTitle),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            PerfilPage(
              userModel: widget.userModel,
            ),
            ComentariosPage(
              userModel: widget.userModel,
            ),
            buildBodyNews(context),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        buttonBackgroundColor: Colors.transparent,
        height: 50,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(
            Icons.person,
            color: _currentIndex == 0
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryIconTheme.color,
          ),
          Icon(
            Icons.message,
            color: _currentIndex == 1
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryIconTheme.color,
          ),
          Icon(
            Icons.rss_feed,
            color: _currentIndex == 2
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryIconTheme.color,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
      ),
    );
  }

  BlocProvider<NewsBloc> buildBodyNews(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewsBloc>(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is Empty) {
                    BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
                    return MessageDisplay(
                      message: 'Iniciando busca!',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return NewsDisplay(news: state.news);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  } else
                    return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
