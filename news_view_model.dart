import 'package:news_app/model/NewsChannelHeadlineModel.dart';
import 'package:news_app/model/caterogy_news_model.dart';
import 'package:news_app/repostirary/news_respostirary.dart';

class NewsViewModel {
  final _repo = NewsRepostirary();
  Future<NewschannelHeadlinemodel> FetchNewsChannelApi(
      String channelName) async {
    final response = await _repo.FetchNewsChannelApi(channelName);
    return response;
  }

  Future<CatgeoryNewsmodel> FetchCaterogyNewsApi(String category) async {
    final response = await _repo.FetchCaterogyNewsApi(category);
    return response;
  }
}
