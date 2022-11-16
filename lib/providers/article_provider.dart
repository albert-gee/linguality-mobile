import 'package:board/models/article.dart';
import 'package:board/providers/article_provider_contract.dart';

import '../configuration/configuration.dart';
import '../utils/api/api.dart';
import '../utils/api/api_response.dart';
import '../utils/key_storage.dart';

class ArticleProvider extends ArticleProviderContract {

  final Configuration settings = Configuration();
  final KeyStorage keyStorage = KeyStorage();
  final Api api = Api();

  @override
  Future<List<Article>> fetchArticles() async {
    ApiResponse apiResponse = await api.get(url: '${settings.apiServerUrl}/article');

    if (apiResponse.statusCode == 200) {
      List<Article> articles = (apiResponse.data as List).map((article) => Article.fromJson(article)).toList();

      return articles;
    } else {
      throw Exception('Couldn\'t fetch articles');
    }
  }

  @override
  Future<Article> fetchArticle(String articleId) async {
    ApiResponse apiResponse = await api.get(url: '${settings.apiServerUrl}/article/$articleId');

    if (apiResponse.statusCode == 200) {
      return Article.fromJson(apiResponse.data);
    } else {
      throw Exception('Couldn\'t fetch articles');
    }
  }
}