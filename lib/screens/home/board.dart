import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

import '../../models/user.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage("assets/images/neurons.jpg"),
        //       fit: BoxFit.cover),
        // ),
        child: Panorama(
          animSpeed: 0,
          // sensorControl: SensorControl.Orientation,
          child: Image.asset('assets/images/panorama.jpg'),
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: <Widget>[
        //     Text(
        //       'Hello, ${user.name}',
        //       style: Theme.of(context).textTheme.headline4,
        //     ),
        //     SizedBox(
        //       height: 300,
        //       width: 300,
        //       child: Panorama(
        //         animSpeed: 1.0,
        //         // sensorControl: SensorControl.Orientation,
        //         child: Image.asset('assets/images/panorama.jpg'),
        //       ),
        //     ),
        //   ],
        // ),
      );
  }
}