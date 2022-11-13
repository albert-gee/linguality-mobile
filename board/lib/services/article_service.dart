import '../models/article.dart';
import '../providers/article_provider_contract.dart';

class ArticleService {
  final ArticleProviderContract articleProvider;

  ArticleService({required this.articleProvider});

  Future<List<Article>> fetchArticles() async {
    return await articleProvider.fetchArticles();
  }
}