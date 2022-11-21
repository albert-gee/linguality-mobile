import 'package:board/models/article.dart';
import 'package:board/models/article_paragraph.dart';
import 'package:board/providers/article_provider_contract.dart';

class TestArticleProvider extends ArticleProviderContract {
  @override
  Future<List<Article>> fetchArticles() async {
    return List.generate(
        10,
        (index) => Article(
              id: index,
              title: 'Article $index',
              imageUrl: 'https://picsum.photos/200/300',
              paragraphs: List.generate(
                  10,
                  (index) => ArticleParagraph(
                        id: index,
                        text: 'Paragraph $index',
                      )),
            ));
  }

  @override
  Future<Article> fetchArticle(String articleId) async {
    return Article(
      id: 1,
      title: 'Test Article',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
      paragraphs: List.generate(
          10,
          (index) => ArticleParagraph(
                id: index,
                text: 'Paragraph $index',
              )),
    );
  }
}
