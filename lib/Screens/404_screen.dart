// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FourOFourScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Center(
        child: Text(
          "404",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
