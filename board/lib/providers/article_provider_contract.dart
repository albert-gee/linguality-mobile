import '../models/article.dart';

abstract class ArticleProviderContract {
  Future<List<Article>> fetchArticles();
}