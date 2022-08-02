import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_example/core/constant/api/api_enum.dart';
import 'package:flutter_test_example/repository/movie/movie_repository.dart';
import 'package:flutter_test_example/view/movie/view/movie_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: ((context) => MovieRepository(Dio(BaseOptions(
            baseUrl: ApiConstant.apiUrl,
            queryParameters: {ApiPath.key.path: ApiConstant.key})))),
        child: const MoviePage(),
      ),
    );
  }
}
