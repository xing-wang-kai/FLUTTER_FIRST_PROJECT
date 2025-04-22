import 'package:flutter/material.dart';
import 'package:my_frist_flutter_project/data/task_inherited.dart';
import 'package:my_frist_flutter_project/screens/form_screen.dart';
import 'package:my_frist_flutter_project/screens/initial_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodersolutions flutter app.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: TaskInherited(child: InitialScreen()),
      initialRoute: "home",
      routes: {
        "home": (context) => TaskInherited(child: InitialScreen(),),
        "form-screen": (context) => FormScreen(taskContext: context),

      },
      //home: FormScreen()
    );
  }
}




