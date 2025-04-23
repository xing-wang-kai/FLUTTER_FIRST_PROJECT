import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

import 'http_interceptor.dart';

class AuthService {
  //TODO: Modularizar a url para ser generico.
  static const String connectionUrl = 'http://192.168.247.1:3000/';
  static const String resource = 'users/';

  Logger logger = Logger();

  http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()],
    requestTimeout: const Duration(seconds: 30)
  );

  Future<bool> loggin({required String email, required String password}) async {
    http.Response response = await client.post(
      Uri.parse("${connectionUrl}login"),
      body: {
        "email": email,
        "password": password
      }
    );

    if(response.statusCode != 200){
      String content = json.decode(response.body);
      switch (content){
        case "Cannot find user":
          throw UserNotFindExceptions();
      }
      throw HttpException(response.body);
    }

    saveUserInfos(body: response.body, useremail: email);
    return true;
  }

  Future<bool> register({required String email, required String password}) async {
    http.Response response = await client.post(
        Uri.parse("${connectionUrl}register"),
        body: {
          "email": email,
          "password": password
        }
    );

    if(response.statusCode != 201){
      throw HttpException(response.body);
    }
    saveUserInfos(body: response.body, useremail: email);
    return true;
  }

  saveUserInfos({required String body, required String useremail}) async{
    Map<String, dynamic> map = json.decode(body);
    String token = map['accessToken'];
    String email = useremail;


    try {

      await Hive.initFlutter();
      var box = await Hive.openBox('service_box');
      box.put("token", token);
      box.put("email", email);
      box.put("userId", "mBVrG3u");

    } catch (e) {
      print('Erro no SharedPreferences: $e');
    }
  }
}

class UserNotFindExceptions implements Exception{}
