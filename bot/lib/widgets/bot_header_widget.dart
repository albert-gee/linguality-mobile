import 'package:flutter/material.dart';

class BotHeaderWidget extends StatelessWidget {
  const BotHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(children: [
        const SizedBox(height: 7.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0))),
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
