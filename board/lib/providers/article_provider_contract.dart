import '../models/article.dart';

abstract class ArticleProviderContract {
  Future<List<Article>> fetchArticles();
  Future<Article> fetchArticle(String articleId);
}