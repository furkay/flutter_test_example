import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_example/core/model/movie.dart';
import 'package:flutter_test_example/view/movie/_widget/_widget.dart';

void main() {
  group('movie loaded widget', () {
    const movies = <Movie>[
      Movie(
        imdbID: '1',
        poster: 'https://picsum.photos/seed/picsum/200/300',
        title: 'title',
        type: 'movie_type',
        year: 'movie_year',
      ),
      Movie(
        imdbID: '2',
        poster: null,
        title: 'title2',
        type: 'movie_type2',
        year: 'movie_year2',
      )
    ];
    setUpAll(() => HttpOverrides.global = null);

    testWidgets('test list item', (tester) async {
      final key = UniqueKey();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: MovieLoadedWidget(key: key, movies: movies)),
      ));
      expect(find.byKey(key), findsOneWidget);

      expect(find.byType(ListTile), findsNWidgets(movies.length));
      expect(find.byType(Placeholder), findsOneWidget);

      //expect(find.text(movies.first.imdbID!), findsOneWidget); -> this scenario directly failed bc I forgot to put imdbId on ListTile!
      expect(find.text(movies.first.title!), findsOneWidget);
      expect(find.widgetWithImage(ListTile, NetworkImage(movies.first.poster!)),
          findsOneWidget);
      expect(
          find.widgetWithText(ListTile, movies.first.title!), findsOneWidget);
    });
  });
}
