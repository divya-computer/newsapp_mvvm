import 'package:newsapp_mvvm/model/news_channel_headlines_model.dart';
import 'package:newsapp_mvvm/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    final response = await _rep.fetchNewsChannelHeadlinesApi();
    return response;
  }

  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewChannelHeadlinesApi(channelName);
    return response;
  }
}
