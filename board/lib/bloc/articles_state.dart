part of 'articles_bloc.dart';

@immutable
abstract class ArticlesState {}

class ArticlesInitialState extends ArticlesState {}

class ArticlesLoadedState extends ArticlesState {
  final List<Article> articles;

  ArticlesLoadedState(this.articles);
}
