import 'ArticleModel.dart';


class NewsMod {
  NewsMod(this.status, this.totalResults, this.articles);

  String status;
  int totalResults;
  List<ArticleModel> articles;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles,
    };
  }

  factory NewsMod.fromJson(Map<String, dynamic> json) => NewsMod(
    json['status'],
    json['totalResults'],
    (json['articles'] as List<dynamic>)
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}