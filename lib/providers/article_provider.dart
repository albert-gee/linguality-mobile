import 'package:board/models/article.dart';
import 'package:board/providers/article_provider_contract.dart';

class ArticleProvider extends ArticleProviderContract {

  @override
  Future<List<Article>> fetchArticles() async {
    await Future.delayed(const Duration(seconds: 3));

    return [
      Article(
        id: '1',
        title: 'How to cook a perfect steak',
        imageUrl: 'https://www.seriouseats.com/thmb/-KA2hwMofR2okTRndfsKtapFG4Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2015__05__Anova-Steak-Guide-Sous-Vide-Photos15-beauty-159b7038c56a4e7685b57f478ca3e4c8.jpg',
        text: 'A perfect steak is a thing of beauty. It’s a thing of joy. It’s a thing of wonder. It’s a thing of, well, steak. And it’s not hard to make. All you need is a little patience, a little know-how, and a little bit of time. And that’s where sous vide comes in. Sous vide is a cooking technique that involves vacuum-sealing food in a plastic bag and then cooking it in a water bath at a precise temperature for a precise amount of time. The result is a perfectly cooked steak every time. And it’s not just steak. You can sous vide just about anything. Chicken, pork, fish, vegetables, eggs, and even desserts. The possibilities are endless. And the results are always delicious. So let’s get started. Here’s how to cook a perfect steak with sous vide.',
      ),
      Article(
        id: '2',
        title: 'My favourite song',
        imageUrl: 'https://img.freepik.com/free-vector/musical-pentagram-sound-waves-notes-background_1017-33911.jpg?w=2000',
        text: 'A perfect steak is a thing of beauty. It’s a thing of joy. It’s a thing of wonder. It’s a thing of, well, steak. And it’s not hard to make. All you need is a little patience, a little know-how, and a little bit of time. And that’s where sous vide comes in. Sous vide is a cooking technique that involves vacuum-sealing food in a plastic bag and then cooking it in a water bath at a precise temperature for a precise amount of time. The result is a perfectly cooked steak every time. And it’s not just steak. You can sous vide just about anything. Chicken, pork, fish, vegetables, eggs, and even desserts. The possibilities are endless. And the results are always delicious. So let’s get started. Here’s how to cook a perfect steak with sous vide.',
      ),
      Article(
        id: '3',
        title: 'When is the best time to go to the gym. When is the best time to go to the gym',
        imageUrl: 'https://placeimg.com/640/480/any',
        text: 'A perfect steak is a thing of beauty. It’s a thing of joy. It’s a thing of wonder. It’s a thing of, well, steak. And it’s not hard to make. All you need is a little patience, a little know-how, and a little bit of time. And that’s where sous vide comes in. Sous vide is a cooking technique that involves vacuum-sealing food in a plastic bag and then cooking it in a water bath at a precise temperature for a precise amount of time. The result is a perfectly cooked steak every time. And it’s not just steak. You can sous vide just about anything. Chicken, pork, fish, vegetables, eggs, and even desserts. The possibilities are endless. And the results are always delicious. So let’s get started. Here’s how to cook a perfect steak with sous vide.',
      ),
    ];
  }

  @override
  Future<Article> fetchArticle(String articleId) async {
    await Future.delayed(const Duration(seconds: 3));

    return Article(
      id: articleId,
      title: 'How to cook a perfect steak',
      imageUrl: 'https://www.seriouseats.com/thmb/-KA2hwMofR2okTRndfsKtapFG4Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2015__05__Anova-Steak-Guide-Sous-Vide-Photos15-beauty-159b7038c56a4e7685b57f478ca3e4c8.jpg',
      text: 'A perfect steak is a thing of beauty. It’s a thing of joy. It’s a thing of wonder. It’s a thing of, well, steak. And it’s not hard to make. All you need is a little patience, a little know-how, and a little bit of time. And that’s where sous vide comes in. Sous vide is a cooking technique that involves vacuum-sealing food in a plastic bag and then cooking it in a water bath at a precise temperature for a precise amount of time. The result is a perfectly cooked steak every time. And it’s not just steak. You can sous vide just about anything. Chicken, pork, fish, vegetables, eggs, and even desserts. The possibilities are endless. And the results are always delicious. So let’s get started. Here’s how to cook a perfect steak with sous vide.',
    );
  }
}