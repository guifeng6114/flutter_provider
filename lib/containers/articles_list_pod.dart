import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_provider/components/article_item.dart';
import 'package:flutter_provider/data_models/articles_model.dart';
import 'package:flutter_provider/models/article_model.dart';
import 'package:hooks_riverpod/all.dart';

/* final articlesProvider =
    ChangeNotifierProvider<ArticlesModel>((_) => ArticlesModel()); */

class Articles extends StateNotifier<List<ArticleModel>> {
  Articles(List<ArticleModel> articles) : super(articles);

  void toggleStar(ArticleModel article) {
    if (!article.isSelected) {
      article.isSelected = true;
    } else {
      article.isSelected = false;
    }
  }
}

final articlesProvider = StateNotifierProvider((ref) {
  final ArticleModel article1 =
      ArticleModel(articleName: '小石潭记', author: '柳宗元', id: 1, isSelected: true);
  final ArticleModel article2 = ArticleModel(
      articleName: '岳阳楼记', author: '范仲淹', id: 2, isSelected: false);
  final ArticleModel article3 = ArticleModel(
      articleName: '醉翁亭记', author: '欧阳修', id: 3, isSelected: false);
  return Articles([article1, article2, article3]);
});

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
            ),
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  Navigator.of(context).pushNamed('/stared');
                })
          ],
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    Articles articlesModel = useProvider(articlesProvider);
    List<ArticleModel> articles = articlesModel.state;
    // articlesModel.init();
    // List<ArticleModel> articles = articlesModel.articles;
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
