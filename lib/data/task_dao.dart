
import 'package:my_frist_flutter_project/data/db_connection.dart';
import 'package:my_frist_flutter_project/widgets/taks_cards.dart';
//
// import 'package:sqflite/sqflite.dart';
//
// class TaskDao {
//   static const String tableSql = 'CREATE TABLE $_tablename('
//       '$_name TEXT, '
//       '$_difficulty INTEGER, '
//       '$_image TEXT)';
//
//   static const String _tablename = 'taskTable';
//   static const String _name = 'name';
//   static const String _difficulty = 'difficulty';
//   static const String _image = 'image';
//
//   save(TaskCardContainer tarefa) async {
//     print('Iniciando o save: ');
//     final Database bancoDeDados = await getDatabase();
//     var itemExists = await find(tarefa.taskName);
//     Map<String, dynamic> taskMap = toMap(tarefa);
//     if (itemExists.isEmpty) {
//       print('a Tarefa não Existia.');
//       return await bancoDeDados.insert(_tablename, taskMap);
//     } else {
//       print('a Tarefa existia!');
//       return await bancoDeDados.update(
//         _tablename,
//         taskMap,
//         where: '$_name = ?',
//         whereArgs: [tarefa.taskName],
//       );
//     }
//   }
//
//   Map<String, dynamic> toMap(TaskCardContainer tarefa) {
//     print('Convertendo to Map: ');
//     final Map<String, dynamic> mapaDeTarefas = Map();
//     mapaDeTarefas[_name] = tarefa.taskName;
//     mapaDeTarefas[_difficulty] = tarefa.star;
//     mapaDeTarefas[_image] = tarefa.imageSource;
//     print('Mapa de Tarefas: $mapaDeTarefas');
//     return mapaDeTarefas;
//   }
//
//   Future<List<TaskCardContainer>> findAll() async {
//     print('Acessando o findAll: ');
//     final Database bancoDeDados = await getDatabase();
//     final List<Map<String, dynamic>> result =
//     await bancoDeDados.query(_tablename);
//     print('Procurando dados no banco de dados... encontrado: $result');
//     return toList(result);
//   }
//
//   List<TaskCardContainer> toList(List<Map<String, dynamic>> mapaDeTarefas) {
//     print('Convertendo to List:');
//     final List<TaskCardContainer> tarefas = [];
//     for (Map<String, dynamic> linha in mapaDeTarefas) {
//       final TaskCardContainer tarefa = TaskCardContainer(
//         linha[_name],
//         linha[_image],
//         linha[_difficulty],
//       );
//       tarefas.add(tarefa);
//     }
//     print('Lista de Tarefas: ${tarefas.toString()}');
//     return tarefas;
//   }
//
//   Future<List<TaskCardContainer>> find(String nomeDaTarefa) async {
//     print('Acessando find: ');
//     final Database bancoDeDados = await getDatabase();
//     print('Procurando tarefa com o nome: ${nomeDaTarefa}');
//     final List<Map<String, dynamic>> result = await bancoDeDados
//         .query(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
//     print('Tarefa encontrada: ${toList(result)}');
//
//     return toList(result);
//   }
//
//   delete(String nomeDaTarefa) async {
//     print('Deletando tarefa: $nomeDaTarefa');
//     final Database bancoDeDados = await getDatabase();
//     return await bancoDeDados.delete(
//       _tablename,
//       where: '$_name = ?',
//       whereArgs: [nomeDaTarefa],
//     );
//   }
// }

import 'package:sqflite/sqflite.dart';


class TaskDao {

  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'Difficulty';
  static const String _image = 'image';

  Map<String, dynamic> toMap(TaskCardContainer task) {
    print("INITIAZER THE CONVERTION TO MAP");

    final Map<String, dynamic> mapOfTaks = Map();
    mapOfTaks[_name] = task.taskName;
    mapOfTaks[_difficulty] = task.star;
    mapOfTaks[_image] = task.imageSource;

    print("TASK MAPS = $mapOfTaks");

    return mapOfTaks;
  }

  List<TaskCardContainer> toList(List<Map<String, dynamic>> mapOfTask){
    print("INITIALIZER THE CONVERTION TO TASK");

    final List<TaskCardContainer> tasks = [];

    for (Map<String, dynamic> line in mapOfTask){
      final TaskCardContainer task = TaskCardContainer(
          line[_name],
          line[_image],
          line[_difficulty],
      );
      tasks.add(task);
    }
    print("LIST OF TASKS  =  ${tasks.toString()}");
    return tasks;
  }

  Future<List<TaskCardContainer>> find(String taskname) async {
    print("INITIALIZER FIND");

    final Database database = await getDatabase();

    print("LOOKING FOR TASKS");

    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [taskname]
    );

    print("TASK FOUNDED = ${toList(result)}");


    return toList(result);
  }

  Future<List<TaskCardContainer>> findAll() async{

    print("INITIALIZER SEARCH");

    final Database database = await getDatabase();
    final List<Map<String, dynamic>> results = await database.query(_tablename);

    print("FIND = $results");

    return toList(results);
  }


  create(TaskCardContainer task) async {
    print('--------------------------------------------');
    print('METHOD CREATE IS BEEN INICIATE');

    final Database database = await getDatabase();
    var itemExists = await find(task.taskName);
    Map<String, dynamic> taskMap = toMap(task);
    if(itemExists.isEmpty){

      print("THIS TASK NOT EXISTS");

      return await database.insert(_tablename, taskMap);
    }else{

      print("THIS TASK ALREADY EXIST");

      return await database.update(
        _tablename,
        taskMap,
        where: "$_name = ?",
        whereArgs: [task.taskName]
      );
    }
  }

  delete(String taskname) async {
    print("REMOVING TASK");

    final Database database = await getDatabase();
    return await database.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [taskname],
    );
  }

}