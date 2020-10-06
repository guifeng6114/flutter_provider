

import 'package:flutter/material.dart';
import 'package:flutter_provider/models/article_model.dart';

class ArticleItem extends StatelessWidget {

  final ArticleModel article;
  final Function action;
  ArticleItem(
    this.article,
    this.action
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${ article.id }.${ article.articleName }'),
      subtitle: Text(article.author),
      trailing: InkWell(
        child: Icon(article.isSelected
          ? Icons.star
          : Icons.star_border,
          color: Colors.blue
        ),
        onTap: () {
          print(article.id);
          action(article);
        },
      ),
    );
  }

}