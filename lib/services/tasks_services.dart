import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:my_frist_flutter_project/services/http_interceptor.dart';
import 'package:my_frist_flutter_project/widgets/taks_cards.dart';

class TaskServices {
  static const String connectionUrl = 'http://192.168.247.1:3000/';
  static const String resource = 'tasks/';

  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  String getUrl() {
    return "$connectionUrl$resource";
  }

  Future<bool> create(TaskCardContainer task) async {

    String jsontask = json.encode(task.toMap());

    http.Response response = await client.post(
        Uri.parse(this.getUrl()),
        headers: {"Content-type": "application/json"},
        body: jsontask);
    if(response.statusCode == 201){
      return true;
    }
    return false;
  }

  Future<List<TaskCardContainer>> readAll() async {
    http.Response response = await client.get(Uri.parse(this.getUrl()));
    if(response.statusCode != 200){
      throw Exception();
    }

    List<TaskCardContainer> tasks = [];

    List<dynamic> responseData = json.decode(response.body);

    for(var item in responseData){
      tasks.add(TaskCardContainer(
          item['taskname'],
          item['imagesource'],
          item["difficulty"]
      ));
    }
    return tasks;
  }

  Future<bool> update(String id, TaskCardContainer task) async {
    String jsontask = json.encode(task.toMap());
    http.Response response = await client.put(
        Uri.parse("${this.getUrl()}$id"),
        headers: {"Content-type": "application/json"},
        body: jsontask);

    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  Future<bool> delete(String  id) async {
    http.Response response = await client.delete(
        Uri.parse("${this.getUrl()}$id"),
        headers: {"Content-type": "application/json"});
    if(response.statusCode == 201){
      return true;
    }
    return false;
  }
}
