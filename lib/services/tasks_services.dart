import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:logger/logger.dart';
import 'package:my_frist_flutter_project/services/http_interceptor.dart';
import 'package:my_frist_flutter_project/widgets/taks_cards.dart';

class TaskServices {
  static const String connectionUrl = 'http://192.168.247.1:3000/';
  static const String resource = 'tasks/';

  Logger logger = Logger();

  http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()],
  );

  String getUrl() {
    return "$connectionUrl$resource";
  }

  Future<bool> create({
    required TaskCardContainer task,
    required String token,
    required String id,
  }) async {

    logger.i("-------------INICIOU O LOGGER -------------");
    Map<String, dynamic> map = task.toMap();
    map["userId"] = id;

    String jsonTask = json.encode(task.toMap());

    http.Response response = await client.post(
      Uri.parse("${connectionUrl}users/$id/tasks/"),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonTask,
    );
    if (response.statusCode != 201) {
      if(json.decode(response.body) == "jwt expired"){
        throw ExpiredTokenException();
      }
      throw Exception("Algo deu erraado");
    }
    return true;
  }

  Future<List<TaskCardContainer>> readAll({
    required String id,
    required String token,
  }) async {
    http.Response response = await client.get(
      Uri.parse("${connectionUrl}users/$id/tasks/"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      if(json.decode(response.body) == "jwt expired"){
        throw ExpiredTokenException();
      }
      throw Exception("Algo deu erraado");
    }

    List<TaskCardContainer> tasks = [];

    List<dynamic> responseData = json.decode(response.body);

    for (var item in responseData) {
      tasks.add(
        TaskCardContainer(
          item['taskname'],
          item['imagesource'],
          item["difficulty"],
        ),
      );
    }
    return tasks;
  }

  Future<bool> update(String id, TaskCardContainer task) async {
    String jsonTask = json.encode(task.toMap());
    http.Response response = await client.put(
      Uri.parse("${getUrl()}$id"),
      headers: {"Content-type": "application/json"},
      body: jsonTask,
    );

    if (response.statusCode != 200) {
      if(json.decode(response.body) == "jwt expired"){
        throw ExpiredTokenException();
      }
      throw Exception("Algo deu erraado");
    }
    return true;
  }

  Future<bool> delete(String id) async {
    http.Response response = await client.delete(
      Uri.parse("${getUrl()}$id"),
      headers: {"Content-type": "application/json"},
    );
    if (response.statusCode != 201) {
      if(json.decode(response.body) == "jwt expired"){
        throw ExpiredTokenException();
      }
      throw Exception("Algo deu erraado");
    }
    return true;
  }
}

class ExpiredTokenException implements Exception{}