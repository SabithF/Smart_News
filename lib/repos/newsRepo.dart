import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_news/models/newsModel.dart';
import 'package:smart_news/consts/newsApiConst.dart';

class NewsRepo{
  //creating a list to fetch news
  Future<List<NewsMod>> fetchNews() async{
    String url = 'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=90c5039899bd4486b226acd867c48adc';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    List<NewsMod> articleModelList = [];
    if(response.statusCode=="ok") {
      for (var data in jsonData[NewsApiConst.articles]) {
        if (data[NewsApiConst.urlToImage] != null) {
          NewsMod articleModel = NewsMod.fromJson(data);
          articleModelList.add(articleModel);
        }
      }
      return articleModelList;
    }else{
    //  emplty list
      return articleModelList;
    }
}
  //creating a list to fetch breaking news list
  Future<List<NewsMod>> fetchBreakingNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=${NewsApiConst.newsApiKey}";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<NewsMod> articleModelList = [];
    if (response.statusCode == "ok") {
      for (var data in jsonData[NewsApiConst.articles]) {
        if (data[NewsApiConst.description].toString().isNotEmpty &&
            data[NewsApiConst.urlToImage].toString().isNotEmpty) {
          NewsMod articleModel = NewsMod.fromJson(data);
          articleModelList.add(articleModel);
        }
      }
      return articleModelList;
    } else {
      // returns an empty list.
      return articleModelList;
    }
  }

  //Creating a list service to pass for search news
  Future<List<NewsMod>> searchNews({required String query}) async {
    String url = '';
    if (query.isEmpty) {
      url =
      'https://newsapi.org/v2/everything?q=biden&from=2022-07-12&sortBy=popularity&apiKey=90c5039899bd4486b226acd867c48adc';
    } else {
      url =
      "https://newsapi.org/v2/everything?q=$query&from=2022-07-12&sortBy=popularity&apiKey=${NewsApiConst.newsApiKey}";
    }

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<NewsMod> articleModelList = [];
    if (response.statusCode == "ok") {
      for (var data in jsonData[NewsApiConst.articles]) {
        if (query.isNotEmpty && data[NewsApiConst.urlToImage] != null) {
          NewsMod articleModel = NewsMod.fromJson(data);
          articleModelList.add(articleModel);
        } else if (query.isEmpty) {
          throw Exception('Query is empty');
        } else {
          throw Exception('Data was not loaded properly');
        }
      }
      return articleModelList;
    } else {
      // returns an empty list.
      return articleModelList;
    }
  }
}


