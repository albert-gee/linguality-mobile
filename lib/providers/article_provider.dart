import 'package:board/models/article.dart';
import 'package:board/providers/article_provider_contract.dart';

class ArticleProvider extends ArticleProviderContract {

  @override
  Future<List<Article>> fetchArticles() async {
    await Future.delayed(Duration(seconds: 5));

    return await [
      Article(
        title: 'How to cook a perfect steak',
        imageUrl: 'https://www.seriouseats.com/thmb/-KA2hwMofR2okTRndfsKtapFG4Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2015__05__Anova-Steak-Guide-Sous-Vide-Photos15-beauty-159b7038c56a4e7685b57f478ca3e4c8.jpg',
      ),
      Article(
          title: 'My favourite song',
          imageUrl: 'https://img.freepik.com/free-vector/musical-pentagram-sound-waves-notes-background_1017-33911.jpg?w=2000'
      ),
      Article(
          title: 'When is the best time to go to the gym. When is the best time to go to the gym',
          imageUrl: 'https://placeimg.com/640/480/any'
      ),
    ];
  }
}