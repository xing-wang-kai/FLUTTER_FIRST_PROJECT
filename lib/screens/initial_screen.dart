import 'package:flutter/material.dart';
import 'package:my_frist_flutter_project/services/tasks_services.dart';
import 'package:my_frist_flutter_project/widgets/taks_cards.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacity = true;

  List<TaskCardContainer> database = [];
  TaskServices services = TaskServices();

  @override
  Widget build(BuildContext context) {
    this.refresh();
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("tasks"),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              this.refresh();
              print("Refreshing...");
            });
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 90),
        child: ListView.builder(
                  itemCount: database.length,
                  itemBuilder: (BuildContext context, int index) {
                    final TaskCardContainer task = database[index];
                    return task;
                  },
                ),
        // child: FutureBuilder<List<TaskCardContainer>>(
        //   future: TaskDao().findAll(),
        //   builder: (context, snapshot) {
        //     List<TaskCardContainer>? tasks = snapshot.data;
        //
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.none:
        //         return Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               CircularProgressIndicator(),
        //               Icon(Icons.downloading, size: 100, color: Colors.green),
        //               Text(
        //                 "Carregando aguarde!!",
        //                 style: TextStyle(fontSize: 32, color: Colors.green),
        //               ),
        //             ],
        //           ),
        //         );
        //         break;
        //       case ConnectionState.waiting:
        //         return Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               CircularProgressIndicator(),
        //               Icon(Icons.downloading, size: 100, color: Colors.green),
        //               Text(
        //                 "Carregando aguarde!!",
        //                 style: TextStyle(fontSize: 32, color: Colors.green),
        //               ),
        //             ],
        //           ),
        //         );
        //         break;
        //       case ConnectionState.active:
        //         return Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               CircularProgressIndicator(),
        //               Icon(Icons.downloading, size: 100, color: Colors.green),
        //               Text(
        //                 "Carregando aguarde!!",
        //                 style: TextStyle(fontSize: 32, color: Colors.green),
        //               ),
        //             ],
        //           ),
        //         );
        //         break;
        //       case ConnectionState.done:
        //         if (snapshot.hasData && tasks != null) {
        //           if (tasks.isNotEmpty) {
        //             return ListView.builder(
        //               itemCount: tasks.length,
        //               itemBuilder: (BuildContext context, int index) {
        //                 final TaskCardContainer task = tasks[index];
        //                 return task;
        //               },
        //             );
        //           }
        //           return Center(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Icon(Icons.error_outline, size: 100, color: Colors.red),
        //                 Text(
        //                   "The database is Empity!!",
        //                   style: TextStyle(fontSize: 32, color: Colors.red),
        //                 ),
        //               ],
        //             ),
        //           );
        //         }
        //         return Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Icon(Icons.error_outline, size: 100, color: Colors.red),
        //               Text(
        //                 "The database is Empity!!",
        //                 style: TextStyle(fontSize: 32, color: Colors.red),
        //               ),
        //             ],
        //           ),
        //         );
        //         break;
        //     }
        //     return Center(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(Icons.error_outline, size: 100, color: Colors.red),
        //           Text(
        //             "The database is Empity!!",
        //             style: TextStyle(fontSize: 32, color: Colors.red),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("form-screen").then((value){

            if(value != null && value == true){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Saved as Succefull!!"))
              );
            }

            setState((){
                print("RELOADING!!");
            });

          });
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (newContext) {
          //       return FormScreen(taskContext: context);
          //     },
          //   ),
          // )
        },
        child: Icon(Icons.add, size: 40),
      ),
    );

  }

  void refresh() async{

    List<TaskCardContainer> tasks = await services.readAll();

    setState(() {
      database = [];
      for(TaskCardContainer task in tasks){
        database.add(task);
      }
    });
  }
}
