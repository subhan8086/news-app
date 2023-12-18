import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/NewsChannelHeadlineModel.dart';
import 'package:news_app/model/caterogy_news_model.dart';

class NewsRepostirary {
  Future<NewschannelHeadlinemodel> FetchNewsChannelApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=d8e770f0b0fb4a39a18786aa89e4a1b1';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NewschannelHeadlinemodel.fromJson(data);
    }
    throw Exception('Error');
  }

  Future<CatgeoryNewsmodel> FetchCaterogyNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=d8e770f0b0fb4a39a18786aa89e4a1b1';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CatgeoryNewsmodel.fromJson(data);
    }
    throw Exception('Error');
  }
}
