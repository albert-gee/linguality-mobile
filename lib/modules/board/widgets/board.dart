import 'package:flutter/material.dart';

import '../../../models/user.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/neurons.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello, ${user.name}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      );
  }
}