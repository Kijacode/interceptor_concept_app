import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:interceptor_concept_app/services/sharedPreference_helper_service.dart';


class HttpServiceInterceptor extends Interceptor{
  
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
   String? username = await SharedPreferenceHelper.getUserToken(key: 'username');
   String? password = await SharedPreferenceHelper.getUserToken(key: 'password');
    if(username!=null && password!=null){
        String basicAuth = base64Encode(utf8.encode('$username:$password'));
    options.headers.addAll({
          'Authorization': 'Basic $basicAuth',
             'Content-Type': 'application/json'
        });      
        print(options.headers.toString());
          return  super.onRequest(options, handler);
    }
    else {
      //get username and password from CurrentUser
  String basicAuth = base64Encode(utf8.encode('$username:$password'));
    options.headers.addAll({
          'Authorization': 'Basic $basicAuth',
          'Content-Type': 'application/json'
        });
           print(options.headers);
    return  super.onRequest(options, handler);
    }

  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);

  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print(err);
    super.onError(err, handler);

  }
}
