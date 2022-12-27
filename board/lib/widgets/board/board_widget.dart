import 'package:board/providers/story_provider_contract.dart';
import 'package:board/widgets/stories/stories_widget.dart';
import 'package:flutter/material.dart';

import '../../providers/article_paragraph_to_speech_provider_contract.dart';

/// This class describes the board screen UI.
class BoardWidget extends StatelessWidget {
  final StoryProviderContract storyProvider;
  final ArticleParagraphToSpeechProviderContract articleParagraphToSpeechProvider;

  final String appTitle;
  final IconData appTitleIcon;

  const BoardWidget({super.key,
    required this.storyProvider,
    required this.articleParagraphToSpeechProvider,
    required this.appTitle,
    required this.appTitleIcon,
  });

  @override
  Widget build(BuildContext context) {
    // /// Send InitArticlesEvent to load articles from the server
    // boardBloc.add(const InitArticlesEvent());

    return StoriesWidget(storyProvider: storyProvider);
    // return BlocProvider(
    //   create: (_) => boardBloc,
    //   child: StoriesWidget(),
    // );
  }


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
// }
