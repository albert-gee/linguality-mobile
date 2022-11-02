
import 'package:flutter/material.dart';

class ReplyButtonWidget extends StatelessWidget {
  const ReplyButtonWidget({super.key, required this.onPressed});

  final void Function() onPressed;


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        print('Pressed');
        onPressed();
      },
      label: const Text('Reply'),
      icon: const Icon(Icons.reply),
      backgroundColor: Colors.pink,
    );
  }
}