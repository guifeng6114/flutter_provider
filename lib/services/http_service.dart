import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_provider/models/article_model.dart';

class HttpService {
  Dio _dio = new Dio();
  static String _ip = '10.237.188.40';
  static String _port = '3400';
  String _address = 'http://$_ip:$_port';

  HttpService._internal();

  static HttpService _singleton = new HttpService._internal();

  factory HttpService() => _singleton;

  Future<bool> login(String user) async {
    final response = await _dio.get('$_address/login?user=$user');
    final data = jsonDecode(response.data);
    if (data['status'] == 'SUCCESS') {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ArticleModel>> getArticles() async {
    final response = await _dio.get('$_address/articles');
    final data = jsonDecode(response.data);
    if (data['status'] == 'SUCCESS') {
      return data['articles']
          .map<ArticleModel>((data) => ArticleModel.fromJson(data))
          .toList();
    } else {
      return []
          .map<ArticleModel>((data) => ArticleModel.fromJson(data))
          .toList();
    }
  }
}
