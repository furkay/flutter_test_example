import 'package:flutter/cupertino.dart';

class MovieExceptionWidget extends StatelessWidget {
  final Exception exception;
  const MovieExceptionWidget(
    this.exception, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(exception);
  }
}
