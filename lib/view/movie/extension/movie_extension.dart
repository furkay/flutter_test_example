import 'package:flutter/material.dart';
import 'package:flutter_test_example/view/movie/_widget/movie_exception_widget.dart';

import '../_widget/movie_loaded_widget.dart';
import '../bloc/movie_bloc.dart';
import '../_widget/movie_loading_widget.dart';

extension MovieExtension on MovieState {
  Widget get widget {
    if (this is MovieLoading) {
      return const MovieLoadingWidget();
    }
    if (this is MovieLoaded) {
      return MovieLoadedWidget(
        movies: (this as MovieLoaded).movies,
      );
    }
    if (this is MovieInitial) {
      return const MovieLoadingWidget();
    }
    if (this is MovieException) {
      return MovieExceptionWidget((this as MovieException).exception);
    }
    return const SizedBox();
  }
}
