import 'package:board/bloc/articles_bloc.dart';
import 'package:board/providers/article_provider_contract.dart';
import 'package:board/widgets/latest_articles_widget.dart';
import 'package:board/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Board extends StatelessWidget {
  Board({super.key, required this.articleProvider})
      : articlesBloc = ArticlesBloc(articleProvider: articleProvider);

  final ArticleProviderContract articleProvider;
  final ArticlesBloc articlesBloc;

  @override
  Widget build(BuildContext context) {
    articlesBloc.add(InitArticlesEvent());

    return BlocProvider(
      create: (_) => articlesBloc,
      child: BlocListener<ArticlesBloc, ArticlesState>(
        listener: (context, state) {
          if (state is ArticlesInitialState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              /// ToDo
            });
          }
        },
        child: BlocBuilder<ArticlesBloc, ArticlesState>(
          builder: (context, state) {

            if (state is ArticlesInitialState) {
              return Column(
                children: const <Widget>[
                  SectionTitle(title: 'Latest Articles'),
                  SizedBox(
                    height: 252,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              );
            } else if (state is ArticlesLoadedState) {
              return Column(
                children: <Widget>[
                  const SectionTitle(title: 'Latest Articles'),
                  LatestArticlesWidget(
                      articles: state.articles
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );



    // return _buildPanorama();
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