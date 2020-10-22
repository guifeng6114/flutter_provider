import 'package:flutter/material.dart';
import 'package:flutter_provider/models/article_model.dart';
import 'package:flutter_provider/services/http_service.dart';

class ArticlesModelPod extends ChangeNotifier {
  final HttpService http = HttpService();

  List<ArticleModel> articles = [];

  List<ArticleModel> staredArticles = [];

  ArticlesModel() {
    init().then((Map<String, List<ArticleModel>> result) {
      print(result);
      articles = result['articles'];
      staredArticles = result['staredArticles'];
    });
  }

  Future<Map<String, List<ArticleModel>>> init() async {
    final getArticles = await http.getArticles();
    final getStaredArticles =
        articles.where((ArticleModel elem) => elem.isSelected).toList();
    return {
      'articles': getArticles,
      'staredArticles': getStaredArticles
    };
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
