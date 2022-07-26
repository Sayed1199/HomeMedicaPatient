import 'dart:convert';

import 'package:get/get.dart';
import 'package:homemedica_patient/models/news_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class NewsController extends GetxController{

  var newsList = Rx<List<Articles>>([]);
  var strToday = Rx<String?>(null);

  Future<void> getNews()async{
    getToday();
    String url = 'https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=${dotenv.env['NEWSAPI']!}';
    http.Response response = await http.get(Uri.parse(url),headers: null);
    NewsModel newsModel = NewsModel.fromJson(jsonDecode(response.body));
    if(newsModel.articles != null)
    newsList.value = newsModel.articles!;
  }

  Future<void> getToday()async{
    strToday.value = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());
  }

}