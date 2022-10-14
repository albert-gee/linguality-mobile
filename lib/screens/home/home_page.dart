import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:linguality_mobile/screens/home/widgets/conversation.dart';

import '../../models/user.dart';
import 'widgets/board.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.user});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _panelHeightOpen = 50;
  double _panelHeightClosed = 800;

  @override
  Widget build(BuildContext context) {
    _panelHeightClosed = MediaQuery.of(context).size.height - 500;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SlidingUpPanel(
        // defaultPanelState: PanelState.OPEN,
        minHeight: _panelHeightOpen,
        maxHeight: _panelHeightClosed,
        defaultPanelState: PanelState.OPEN,


        panel: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Conversation(),
          ],
        ),
        body: Board(user: widget.user),

      ),
    );
  }
}
