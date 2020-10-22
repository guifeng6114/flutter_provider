import 'package:flutter/material.dart';
import 'package:flutter_provider/components/article_item.dart';
import 'package:flutter_provider/data_models/articles_model.dart';
import 'package:provider/provider.dart';

class ArticlesListPage extends StatefulWidget {
  @override
  _ArticlesListPageState createState() => _ArticlesListPageState();
}

class _ArticlesListPageState extends State<ArticlesListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ArticlesModel>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ARTICLES'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  Provider.of<ArticlesModel>(context, listen: false).reset();
                }),
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
    return Consumer<ArticlesModel>(
      builder: (context, articlesModel, child) {
        final articles = articlesModel.articles;
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
      },
    );
  }
}
