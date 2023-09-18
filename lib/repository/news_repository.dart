import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp_mvvm/model/news_channel_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=6f7ffdb6700b4041951404b0e56221df');
    final response = await http.get(url);

    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=6f7ffdb6700b4041951404b0e56221df';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
