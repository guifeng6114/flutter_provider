class ArticleModel {
  final String articleName;
  final String author;
  final int id;
  bool isSelected;

  ArticleModel({this.id, this.articleName, this.author, this.isSelected});

  ArticleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        articleName = json['articleName'] as String,
        author = json['author'] as String,
        isSelected = json['isSelected'] as bool;
}
