import 'package:bloc/bloc.dart';
import 'package:board/providers/article_provider_contract.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/article.dart';
import '../services/article_service.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {

  final ArticleProviderContract articleProvider;
  final ArticleService articleService;

  ArticlesBloc({required this.articleProvider})
      : articleService = ArticleService(articleProvider: articleProvider),
        super(ArticlesInitialState()
  ) {
    print('===ArticlesBloc===');

    on<InitArticlesEvent>((event, emit) async {
      print('ON InitArticlesEvent');

      
      emit(ArticlesInitialState());


      final List<Article> articles = await articleService.fetchArticles();
      emit(ArticlesLoadedState(articles));
    });

    on<InitArticlesCompletedEvent>((event, emit) async {

      print('ON InitArticlesCompletedEvent');
    });

  }
}
