import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/login_page.dart';
import 'features/microblogging/presentation/pages/news_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light().copyWith(
          primaryColor: Color(0xFF619f7f), accentColor: Color(0xFF619f7f)),
      // home: NewsPage(),
      home: LoginPage(),
    );
  }
}
