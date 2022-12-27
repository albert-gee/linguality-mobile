import 'package:flutter/material.dart';

class BoardLoadingWidget extends StatelessWidget {
  const BoardLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 252,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}