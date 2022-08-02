import 'package:dio/dio.dart';
import 'package:flutter_test_example/core/base/repository/i_base_repository.dart';
import 'package:flutter_test_example/core/constant/exception/exception_enum.dart';
import 'package:flutter_test_example/core/constant/request/request_enum.dart';

import '../../exception/exception.dart';

class IDioRepository extends IBaseRepository {
  final Dio _client;

  const IDioRepository(this._client);

  Future<Response> request(
      {required RequestType requestType,
      required String path,
      Map<String, dynamic>? queryParameters}) async {
    if (queryParameters != null) {
      _client.options.queryParameters = _client.options.queryParameters
        ..addAll(queryParameters);
    }
    switch (requestType) {
      case RequestType.get:
        return _client.get(path);
      case RequestType.post:
        return _client.post(path);
      case RequestType.put:
        return _client.put(path);
      case RequestType.delete:
        return _client.delete(path);
      default:
        return throw RequestTypeException(
            ExceptionEnum.requestTypeException.message);
    }
  }

  void close() {
    _client.close();
  }
}
