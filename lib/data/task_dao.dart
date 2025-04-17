
import 'package:my_frist_flutter_project/data/db_connection.dart';
import 'package:my_frist_flutter_project/widgets/taks_cards.dart';
import 'package:sqflite/sqflite.dart';


class TaskDao {

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'Difficulty';
  static const String _image = 'image';

  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

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
          line[_difficulty],
          line[_image]
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