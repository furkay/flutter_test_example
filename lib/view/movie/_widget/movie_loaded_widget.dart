import 'package:flutter/material.dart';

import '../../../core/model/movie.dart';

class MovieLoadedWidget extends StatelessWidget {
  final List<Movie> movies;
  const MovieLoadedWidget({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(),
      itemCount: movies.length,
      shrinkWrap: true,
      itemBuilder: (_, index) => ListTile(
        leading: movies[index].poster != null
            ? Image.network(movies[index].poster!)
            : const SizedBox(height: 10, width: 10, child: Placeholder()),
        title: Text(movies[index].title ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {},
      ),
    );
  }
}
