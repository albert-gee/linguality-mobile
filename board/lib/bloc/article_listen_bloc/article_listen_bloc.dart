import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:board/models/article.dart';
import 'package:equatable/equatable.dart';

import '../../services/article_paragraph_to_speech/article_paragraph_to_speech_service_contract.dart';

part 'article_listen_event.dart';

part 'article_listen_state.dart';

/// This class describes the business logic of the article listen button.
class ArticleListenBloc extends Bloc<ArticleListenEvent, ArticleListenState> {
  final ArticleParagraphToSpeechServiceContract articleParagraphToSpeechService;
  final AudioPlayer audioPlayer = AudioPlayer();
  final Article article;

  ArticleListenBloc({required this.articleParagraphToSpeechService, required this.article})
      : super(const ArticleListenInitialState()) {

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
        emit(const ArticleListenInitialState());
      }

      /// ArticleListenPauseEvent
      if (event is ArticleListenPauseEvent) {
        await audioPlayer.pause();
        emit(const ArticleListenPausedState());
      }
    });
  }

  Future<void> _playParagraph(String articleId, String paragraphId) async {
    add(const ArticleListenPlayEvent());
    final String url = await articleParagraphToSpeechService.convert(articleId, paragraphId);
    await audioPlayer.play(DeviceFileSource(url));
  }
}
