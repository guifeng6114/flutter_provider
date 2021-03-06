
import 'package:flutter/material.dart';
import 'package:flutter_provider/components/article_item.dart';
import 'package:flutter_provider/data_models/articles_model.dart';
import 'package:provider/provider.dart';

class ArticleStarredPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STARED'),
      ),
      body: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<ArticlesModel>(
      builder: (context, articlesModel, child) {
        final articles = articlesModel.staredArticles;
        return Container(
          child: ListView.separated(
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              return ArticleItem(
                articles[index],
                articlesModel.toggleStar
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 0.5,
              color: Colors.black26,
            )
          ),
        );
      },
    );
  }

}