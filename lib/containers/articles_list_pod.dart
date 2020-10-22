import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_provider/components/article_item.dart';
import 'package:flutter_provider/data_models/articles_model.dart';
import 'package:flutter_provider/models/article_model.dart';
import 'package:hooks_riverpod/all.dart';

final articlesProvider =
    ChangeNotifierProvider<ArticlesModel>((_) => ArticlesModel());

class ArticlesListPodPage extends HookWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ARTICLES'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.collections_bookmark),
              onPressed: () {
                Navigator.of(context).pushNamed('/stared');
              },
            )
          ],
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    ArticlesModel articlesModel = useProvider(articlesProvider);
    List<ArticleModel> articles = articlesModel.articles;
    return Container(
      child: ListView.separated(
          itemCount: articles.length,
          itemBuilder: (BuildContext context, int index) {
            return ArticleItem(articles[index], articlesModel.toggleStar);
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: 0.5,
                color: Colors.black26,
              )),
    );
  }
}
