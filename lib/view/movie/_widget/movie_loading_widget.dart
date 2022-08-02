import 'package:flutter/material.dart';

class MovieLoadingWidget extends StatelessWidget {
  const MovieLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive();
  }
}
