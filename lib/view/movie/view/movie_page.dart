import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_example/repository/movie/movie_repository.dart';
import 'package:flutter_test_example/view/movie/bloc/movie_bloc.dart';
import 'package:flutter_test_example/view/movie/extension/movie_extension.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> searchText = ValueNotifier('');
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => MovieBloc(
          context.read<MovieRepository>(),
        )..add(MovieInit()),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: ((context, state) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        suffixIcon: ValueListenableBuilder<String>(
                            valueListenable: searchText,
                            builder: (context, text, _) {
                              return IconButton(
                                onPressed: () => context
                                    .read<MovieBloc>()
                                    .add(MovieSearch(text)),
                                icon: const Icon(Icons.search),
                              );
                            }),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: Colors.grey.withOpacity(.2),
                        filled: true,
                      ),
                      onChanged: (val) => searchText.value = val,
                    ),
                  ),
                  Expanded(child: state.widget),
                ],
              )),
        ),
      ),
    );
  }
}
