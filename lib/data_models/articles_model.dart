import 'package:flutter/material.dart';
import 'package:flutter_provider/models/article_model.dart';
import 'package:flutter_provider/services/http_service.dart';

class ArticlesModel extends ChangeNotifier {
  final HttpService http = HttpService();

  List<ArticleModel> articles = [];

  List<ArticleModel> staredArticles = [];

  void init() async {
    articles = await http.getArticles();
    staredArticles =
        articles.where((ArticleModel elem) => elem.isSelected).toList();
    notifyListeners();
  }

  void toggleStar(ArticleModel article) {
    if (!article.isSelected) {
      article.isSelected = true;
      staredArticles.add(article);
    } else {
      article.isSelected = false;
      staredArticles.remove(article);
    }
    notifyListeners();
  }

  void reset() {
    articles = articles.map<ArticleModel>((ArticleModel article) {
      article.isSelected = false;
      return article;
    }).toList();
    staredArticles = [];
    notifyListeners();
  }
}
