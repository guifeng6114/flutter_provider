import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_provider/components/article_item.dart';
import 'package:flutter_provider/data_models/articles_model.dart';
import 'package:flutter_provider/models/article_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:provider/provider.dart';

class Articles extends StateNotifier<List<ArticleModel>> {
  Articles(List<ArticleModel> articles) : super(articles);

  void toggleStar(ArticleModel article) {
    final curIndex = state.lastIndexWhere((ArticleModel art) => art == article);
    final curArticle = state[curIndex];
    if (!curArticle.isSelected) {
      curArticle.isSelected = true;
    } else {
      curArticle.isSelected = false;
    }
    state = [
      ...state.getRange(0, curIndex),
      curArticle,
      ...state.getRange(curIndex + 1, state.length)
    ];
  }
}

final ArticleModel article1 =
    ArticleModel(articleName: '小石潭记', author: '柳宗元', id: 1, isSelected: true);
final ArticleModel article2 =
    ArticleModel(articleName: '岳阳楼记', author: '范仲淹', id: 2, isSelected: false);
final ArticleModel article3 =
    ArticleModel(articleName: '醉翁亭记', author: '欧阳修', id: 3, isSelected: false);
final articlesProvider = StateNotifierProvider((ref) {
  return Articles([article1, article2, article3]);
});

class ArticleStarredPodPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('STARED'),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    Articles articlesModel = useProvider(articlesProvider);
    List<ArticleModel> articles = articlesModel.state;
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
