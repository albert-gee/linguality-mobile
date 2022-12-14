import 'package:board/bloc/board_bloc.dart';
import 'package:board/providers/article_provider_contract.dart';
import 'package:board/widgets/article_widget.dart';
import 'package:board/widgets/latest_articles_widget.dart';
import 'package:board/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Board extends StatelessWidget {
  Board({super.key, required this.articleProvider})
      : boardBloc = BoardBloc(articleProvider: articleProvider);

  final ArticleProviderContract articleProvider;
  final BoardBloc boardBloc;

  @override
  Widget build(BuildContext context) {
    boardBloc.add(InitArticlesEvent());

    return BlocProvider(
      create: (_) => boardBloc,
      child: BlocListener<BoardBloc, BoardState>(
        listener: (context, state) {
          if (state is BoardInitialState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              /// ToDo
            });
          }
        },
        child: BlocBuilder<BoardBloc, BoardState>(
          builder: (context, state) {

            if (state is BoardInitialState) {
              /// BoardInitialState
              return Column(
                children: <Widget>[
                  const SectionTitleWidget(title: 'Latest Articles'),
                  _addProgressBar(),
                ],
              );
            } else if (state is ArticlesLoadedState) {
              /// ArticlesLoadedState
              return Column(
                children: <Widget>[
                  const SectionTitleWidget(title: 'Latest Articles'),
                  LatestArticlesWidget(
                    boardBloc: boardBloc,
                    articles: state.articles
                  ),
                ],
              );
            } else if (state is OpenArticleInitState) {
              /// OpenArticleInitState
              return Column(
                children: <Widget>[
                  const SectionTitleWidget(title: 'Latest Articles'),
                  _addProgressBar(),
                ],
              );
            } else if (state is OpenArticleCompletedState) {
              /// OpenArticleCompletedState
              return ArticleWidget(article: state.article);
            } else {
              return Container();
            }
          },
        ),
      ),
    );

    // return _buildPanorama();
  }

  Widget _addProgressBar() {
    return const SizedBox(
      height: 252,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  // Widget _buildPanorama() {
  //   return Container(
  //     constraints: const BoxConstraints.expand(),
  //     // decoration: const BoxDecoration(
  //     //   image: DecorationImage(
  //     //       image: AssetImage("assets/images/neurons.jpg"),
  //     //       fit: BoxFit.cover),
  //     // ),
  //     child: Panorama(
  //       animSpeed: 0,
  //       // sensorControl: SensorControl.Orientation,
  //       child: Image.asset('assets/images/panorama.jpg', package: 'board'),
  //     ),
  //     // Column(
  //     //   mainAxisAlignment: MainAxisAlignment.start,
  //     //   children: <Widget>[
  //     //     Text(
  //     //       'Hello, ${user.name}',
  //     //       style: Theme.of(context).textTheme.headline4,
  //     //     ),
  //     //     SizedBox(
  //     //       height: 300,
  //     //       width: 300,
  //     //       child: Panorama(
  //     //         animSpeed: 1.0,
  //     //         // sensorControl: SensorControl.Orientation,
  //     //         child: Image.asset('assets/images/panorama.jpg'),
  //     //       ),
  //     //     ),
  //     //   ],
  //     // ),
  //   );
  // }
}