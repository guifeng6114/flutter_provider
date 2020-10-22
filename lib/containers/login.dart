import 'package:flutter/material.dart';
import 'package:flutter_provider/data_models/articles_model.dart';
import 'package:flutter_provider/services/http_service.dart';
import 'package:hooks_riverpod/all.dart';

final articlesProvider =
    ChangeNotifierProvider<ArticlesModel>((_) => ArticlesModel());

class LoginPage extends StatelessWidget {
  final TextEditingController _loginTextController = TextEditingController();
  final HttpService http = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[_buildLoginArea(context)],
    );
  }

  Widget _buildLoginArea(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[flutterLogo(), userNameInput(), buttonArea(context)],
      ),
    );
  }

  Widget userNameInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
      child: TextField(
          controller: _loginTextController,
          autofocus: false,
          decoration: InputDecoration(
              labelText: 'Username or Email', hintText: 'Input username')),
    );
  }

  Widget buttonArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 131.0, vertical: 12.0),
        child: Text('Login',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () async {
          print(_loginTextController.text);
          final user = _loginTextController.text;
          final result = await http.login(user);
          if (result) {
            if (user == 'pod') {
              Navigator.of(context).pushReplacementNamed('/articles-pod');
              context.read(articlesProvider).init();
            } else {
              Navigator.of(context).pushReplacementNamed('/articles');
            }
          }
        },
        color: Colors.blue,
      ),
    );
  }

  Widget flutterLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      padding: EdgeInsets.all(10.0),
      child: FlutterLogo(size: 80.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.only(bottom: 20.0),
    );
  }
}
