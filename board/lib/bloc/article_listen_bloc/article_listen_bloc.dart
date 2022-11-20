import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:board/models/article.dart';
import 'package:board/providers/article_paragraph_to_speech_provider_contract.dart';
import 'package:equatable/equatable.dart';

part 'article_listen_event.dart';

part 'article_listen_state.dart';

class ArticleListenBloc extends Bloc<ArticleListenEvent, ArticleListenState> {
  final ArticleParagraphToSpeechProviderContract articleParagraphToSpeechProvider;
  final AudioPlayer audioPlayer = AudioPlayer();
  final Article article;

  ArticleListenBloc({required this.articleParagraphToSpeechProvider, required this.article})
      : super(ArticleListenInitialState(article: article)) {

    on<ArticleListenEvent>((event, emit) async {
      // audioPlayer.onPositionChanged.listen((event) {
      // });

      /// ArticleListenPlayPressedEvent
      if (event is ArticleListenPlayPressedEvent) {
        // Listen pressed
        Article article = event.article;
        int elementId = 0;

        audioPlayer.onPlayerComplete.listen((void e) async {
          add(const ArticleListenCompletedEvent());
          if (elementId == article.paragraphs.length - 1) {
            await audioPlayer.dispose();
          } else {
            elementId++;
            await _playParagraph(article.id.toString(), article.paragraphs[elementId].id.toString());
          }
        });

        await _playParagraph(article.id.toString(), article.paragraphs[elementId].id.toString());
      }

      /// ArticleListenPlayEvent
      if (event is ArticleListenPlayEvent) {
        await audioPlayer.resume();
        emit(const ArticleListenPlayingState());
      }

      /// ArticleListenCompletedEvent
      if (event is ArticleListenCompletedEvent) {
        emit(ArticleListenInitialState(article: article));
      }

      if (event is ArticleListenPauseEvent) {
        await audioPlayer.pause();
        emit(ArticleListenPausedState(article.id.toString()));
      }
    });
  }

  Future<void> _playParagraph(String articleId, String paragraphId) async {
    add(const ArticleListenPlayEvent());
    final String url = await articleParagraphToSpeechProvider.convert(articleId, paragraphId);
    await audioPlayer.play(DeviceFileSource(url));
  }
}
