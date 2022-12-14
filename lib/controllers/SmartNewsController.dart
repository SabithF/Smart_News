import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_news/consts/newsApiConst.dart';
import 'package:smart_news/models/ArticleModel.dart';
import 'package:smart_news/models/newsModel.dart';


class SmartNewsController extends GetxController {
//  creating a list view
List<ArticleModel> allNews = <ArticleModel>[];

//for carousal view
List<ArticleModel> breakingNews = <ArticleModel>[];
//Creating controller for the scroll view
ScrollController scrollController = ScrollController();
RxBool articleNotAvailable = false.obs;
RxBool isLoading =false.obs;
  RxString cName = ''.obs;
  RxString country = ''.obs;
  RxString category = ''.obs;
  RxString channel = ''.obs;
  RxString searchNews = ''.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 10.obs;
  //declaration of endpoint url
  String baseUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=90c5039899bd4486b226acd867c48adc";
  //

  @override
  void Init(){
   scrollController = ScrollController()..addListener(_scrollListener);
   getAllNews();
   getBreakingNews();
   super.onInit();
  }
  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading.value = true;
      getAllNews();
    }
  }
  //breaking news
  getBreakingNews({reload = false}) async {
    articleNotAvailable.value = false;

    if (!reload && isLoading.value == false) {
    } else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    //endpoint assigning
    baseUrl ="https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&";
    // "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=90c5039899bd4486b226acd867c48adc";

    // default country is set to US
    baseUrl += country.isEmpty ? 'country=us&' : 'country=$country&';
    //baseApi += category.isEmpty ? '' : 'category=$category&';
    baseUrl += 'apiKey=${NewsApiConst.newsApiKey}';
    print([baseUrl]);
    // calling the API function and passing the URL here
    getBreakingNewsFromApi(baseUrl);
  }


  //Display all news and seach function
  getAllNews({channel= '', searchKey= '', reload= false})async{
    if (!reload && isLoading.value == false)
    {} else {
        country.value ='';
        category.value= '';
    }
      if (isLoading == true){
        pageNum++;
      } else {
        allNews = [];

        pageNum.value = 2;
      }
    // ENDPOINT
    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";
    // default country is set to India
    baseUrl += country.isEmpty ? 'country=in&' : 'country=$country&';
    // default category is set to Business
    baseUrl += category.isEmpty ? 'category=business&' : 'category=$category&';
    baseUrl += 'apiKey=${NewsApiConst.newsApiKey}';
    if (channel != '') {
      country.value = '';
      category.value = '';
      baseUrl =
      "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=${NewsApiConst.newsApiKey}";
    }
    if (searchKey != '') {
      country.value = '';
      category.value = '';
      baseUrl =
      "https://newsapi.org/v2/everything?q=$searchKey&from=2022-07-01&sortBy=popularity&pageSize=10&apiKey=${NewsApiConst.newsApiKey}";
    }
    print(baseUrl);
    // calling the API function and passing the URL here
    getAllNewsFromApi(baseUrl);
  }
  //retrieving all breaking news from newsApi

  getBreakingNewsFromApi(url) async {
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == "ok") {
      NewsMod newsData = NewsMod.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotAvailable.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          // combining two list instances with spread operator
          breakingNews = [...breakingNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            breakingNews = newsData.articles;
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotAvailable.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotAvailable.value = true;
      update();
    }
  }

  //retrieving all news from newsApi
  getAllNewsFromApi(url) async {
  //  creating an object to pass the URI String.
    http.Response res = await http.get(Uri.parse(url));
    //status code is 200 or ok
    if (res.statusCode=="ok"){
    //  pass the string and return the result
      NewsMod newsData = NewsMod.fromJson(jsonDecode(res.body));

      //argument if news data is empty
      if (newsData.articles.isEmpty && newsData.totalResults==0){
        articleNotAvailable.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          // combining two list instances with spread operator
          allNews = [...allNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            allNews = newsData.articles;
            // list scrolls back to the start of the screen
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotAvailable.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotAvailable.value = true;
      update();
    }
  }

}
