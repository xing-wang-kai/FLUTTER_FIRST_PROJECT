import 'package:flutter/material.dart';
import 'package:my_frist_flutter_project/widgets/taks_cards.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<TaskCardContainer> taskList = [
    TaskCardContainer(
        "Estudar Flutter",
        "dash.png",
        2
    ),
    TaskCardContainer(
      "Andar de Bicke",
      "bike.webp",
      3,
    ),
    TaskCardContainer(
      "Trabalhar",
      "meditar.jpeg",
      4,
    ),
    TaskCardContainer(
      "Ler mais",
      "livro.jpg",
      5,
    ),
    TaskCardContainer(
      "Fazer bolo",
      "jogar.jpg",
      3,
    ),
    TaskCardContainer(
        "jogar subnautica",
        "jogar.jpg",
        1
    ),
    TaskCardContainer(
        "Assistir videos com VR",
        "meditar.jpeg",
        2
    ),
  ];

  void saveNewTask(String name, String photo, int difficulty){
    taskList.add(TaskCardContainer(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<
        TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
