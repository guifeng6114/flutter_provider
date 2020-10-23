import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_provider/components/article_item.dart';
import 'package:flutter_provider/data_models/articles_model.dart';
import 'package:flutter_provider/data_models/articles_model_pod.dart';
import 'package:flutter_provider/models/article_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final articlesProvider =
    ChangeNotifierProvider<ArticlesModelPod>((_) => ArticlesModelPod());

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
    ArticlesModelPod articlesModel = useProvider(articlesProvider);
    List<ArticleModel> articles = articlesModel.staredArticles;
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
