import 'package:flutter/material.dart';
import 'package:my_frist_flutter_project/data/task_dao.dart';
import 'package:my_frist_flutter_project/data/task_inherited.dart';
import 'package:my_frist_flutter_project/widgets/taks_cards.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isNetWork(){
    if(imageController.text.contains("http")){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(title: Text("Fill your new task there")),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Insira o nome da Tarefa";
                        }
                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "None",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      controller: difficultyController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Difficulty",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "imagem",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 72,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.blue),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: isNetWork()? Image.asset(
                          imageController.text,
                          fit: BoxFit.cover,
                          errorBuilder: (
                              BuildContext context,
                              Object exception,
                              StackTrace? stackTrace,
                              ) {
                            return Container();
                          },
                        ): Image.asset(
                          "assets/images/${imageController.text}",
                          fit: BoxFit.cover,
                          errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) {
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                        TaskDao().create(
                          TaskCardContainer(
                              nameController.text,
                              imageController.text,
                              int.parse(difficultyController.text),
                          )
                        );

                        // TaskInherited.of(widget.taskContext).saveNewTask(
                        //   nameController.text,
                        //   imageController.text,
                        //   int.parse(difficultyController.text),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text("Saving the new task...")),
                        // );
                        // Navigator.pop(context);
                        Navigator.of(context).pushNamed("home");
                      }
                    },
                    child: Text("Adicionar!"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
