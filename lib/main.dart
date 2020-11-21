import 'package:flutter/material.dart';
import 'package:hacker_news/src/ui/page/home_page.dart';
import 'package:hacker_news/res/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  BottomNavigationBarThemeData _bottomNavigationBarTheme(BuildContext context) {
    return Theme.of(context).bottomNavigationBarTheme.copyWith(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey);
  }

  final _textTheme = const TextTheme(
    // subtitle1: const TextStyle(fontWeight: FontWeight.w100),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: "Times New Roman",
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(elevation: 0),
        bottomNavigationBarTheme: _bottomNavigationBarTheme(context),
        textTheme: _textTheme,
      ),
      home: HomePage(title: 'Hacker News'),
    );
  }
}
