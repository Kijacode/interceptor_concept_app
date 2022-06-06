
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:interceptor_concept_app/config/config.dart';
import 'package:interceptor_concept_app/services/http_service_interceptor.dart';

class HttpService {

  final _dio = Dio();

HttpService(){
 _dio.options.baseUrl=AppConfig.baseUrl;
 _dio.options.connectTimeout = 5000; //5s
 _dio.options.receiveTimeout = 3000;
 _dio.options.headers = {
    'Content-Type': 'application/json',
  };
 _dio.interceptors.clear();
 _dio.interceptors.add(HttpServiceInterceptor());
}

 Future<Response> httpPost(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.post(
      url,
      queryParameters: queryParameters,
      data: body,
    );
  }


  Future<Response> httpPut(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.put(
      url,
      queryParameters: queryParameters,
      data: body,
    );
  }

  Future<Response> httpDelete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.delete('/$url', queryParameters: queryParameters);
  }

  Future<Response> httpGet(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

  Future<Response> httpGetPagination(
    String url,
    Map<String, dynamic> queryParameters,
  ) async {
    Map<String, dynamic> dataQueryParameters = {
      'totalPages': 'true',
      'pageSize': '1',
      'fields': 'none',
    };
    dataQueryParameters.addAll(queryParameters);
    return await httpGet(url, queryParameters: dataQueryParameters);
  }

}