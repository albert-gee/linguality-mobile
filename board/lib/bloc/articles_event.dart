part of 'articles_bloc.dart';

abstract class ArticlesEvent extends Equatable {}

class InitArticlesEvent extends ArticlesEvent {
  InitArticlesEvent();

  @override
  List<Object> get props => [];
}

class InitArticlesCompletedEvent extends ArticlesEvent {
  InitArticlesCompletedEvent();

  @override
  List<Object> get props => [];
}