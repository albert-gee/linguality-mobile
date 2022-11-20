import 'package:bloc/bloc.dart';
import 'package:board/providers/article_provider_contract.dart';
import 'package:equatable/equatable.dart';

import '../../models/article.dart';
import '../../providers/article_paragraph_to_speech_provider_contract.dart';
import '../../services/article_service.dart';

part 'board_event.dart';

part 'board_state.dart';

/// This class describes the business logic of the board screen.
class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final ArticleProviderContract articleProvider;
  final ArticleService articleService;
  final ArticleParagraphToSpeechProviderContract articleParagraphToSpeechProvider;

  BoardBloc({required this.articleParagraphToSpeechProvider, required this.articleProvider})
      : articleService = ArticleService(articleProvider: articleProvider),
        super(BoardInitialState()) {
    /// InitArticlesEvent
    /// Load articles from the server
    on<InitArticlesEvent>((event, emit) async {
      emit(BoardInitialState());
      final List<Article> articles = await articleService.fetchArticles();
      emit(ArticlesLoadedState(articles));
    });

    /// InitArticlesCompletedEvent
    /// Load articles from the server is completed
    on<InitArticlesCompletedEvent>((event, emit) async {});

    /// OpenArticleEvent
    /// Open article
    on<OpenArticleEvent>((event, emit) async {
      emit(OpenArticleInitState());
      final Article article = await articleService.fetchArticle(event.articleId);
      emit(OpenArticleCompletedState(article, articleParagraphToSpeechProvider));
    });
  }
}
