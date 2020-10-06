

import 'package:dio/dio.dart';
import 'package:flutter_provider/models/article_model.dart';

class HttpService {
  Dio _dio = new Dio();
  static String _ip = 'localhost';
  static String _port = '3400';
  String _address = 'http://$_ip:$_port';

  HttpService._internal();

  static HttpService _singleton = new HttpService._internal();

  factory HttpService() => _singleton;

  Future<bool> login(String user) async {
    // final result = await _dio.get('$_address/login?user=$user');
    return await true;
  }

  Future<List<ArticleModel>> getArticles() async {
    final List<ArticleModel> articles = [
      ArticleModel(1, '小石潭记', '柳宗元', true),
      ArticleModel(2, '岳阳楼记', '范仲淹', false),
      ArticleModel(3, '醉翁亭记', '欧阳修', false),
    ];
    return await articles;
  }
}