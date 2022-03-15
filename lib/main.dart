

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotlas_test/components/feed/bloc/feed_screen_bloc.dart';
import 'package:spotlas_test/components/feed/bloc/feed_screen_event.dart';
import 'package:spotlas_test/components/feed/feed_screen.dart';
import 'package:spotlas_test/stores/repositories/recommendation_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotlas Test',
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      home: BlocProvider(create: (context) => FeedScreenBloc(RecommendationRepository())..add(LoadRecommendations(recommendations: const [], pageKey: 1)), child: const FeedScreen()),
    );
  }

  ThemeData getTheme() => ThemeData(
    fontFamily: 'SFProDisplay',
    primaryColor: Colors.pink,
    backgroundColor: Colors.white,
    indicatorColor: Colors.yellow,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.grey,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0, titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16)),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
      bodyText2: TextStyle(color: Colors.black87, fontWeight: FontWeight.w200, fontSize: 16),
      //white
      headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
      //grey
      headline2: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 16),
      //black
      headline3: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
    ),
  );
}
