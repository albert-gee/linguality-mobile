import 'package:flutter/material.dart';

class BotSliderWidget extends StatelessWidget {
  const BotSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(0)),
      ),
      child: Column(children: [
        const SizedBox(height: 7.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration:
                  BoxDecoration(color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),
        const SizedBox(
          height: 7.0,
        )
      ]),
    );
  }
}
