import 'package:flutter/material.dart';
import 'package:flutter_provider/containers/articles_list.dart';
import 'package:hooks_riverpod/all.dart';
// import 'package:provider/provider.dart';

import 'containers/articles_list_pod.dart';
import 'containers/articles_star.dart';
import 'containers/articles_star_pod.dart';
import 'containers/login.dart';
import 'data_models/articles_model.dart';

void main() {
  /* runApp(ChangeNotifierProvider(
    create: (context) => ArticlesModel(),
    child: MyApp(),
  )); */

  runApp(ProviderScope(
    child: MyAppPod(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
        routes: {
          '/articles': (context) => ArticlesListPage(),
          '/stared': (context) => ArticleStarredPage()
        });
  }
}

class MyAppPod extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
        routes: {
          '/articles-pod': (context) => ArticlesListPodPage(),
          '/stared-pod': (context) => ArticleStarredPodPage()
        });
  }
}
