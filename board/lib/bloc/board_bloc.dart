import 'package:bloc/bloc.dart';
import 'package:board/providers/article_provider_contract.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/article.dart';
import '../services/article_service.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {

  final ArticleProviderContract articleProvider;
  final ArticleService articleService;

  BoardBloc({required this.articleProvider})
      : articleService = ArticleService(articleProvider: articleProvider),
        super(BoardInitialState()
  ) {

    on<InitArticlesEvent>((event, emit) async {
      emit(BoardInitialState());
      final List<Article> articles = await articleService.fetchArticles();
      emit(ArticlesLoadedState(articles));
    });

    on<InitArticlesCompletedEvent>((event, emit) async {
    });

    on<OpenArticleEvent>((event, emit) async {
      emit(OpenArticleInitState());
      final Article article = await articleService.fetchArticle(event.articleId);
      emit(OpenArticleCompletedState(article));
    });

  }
}
