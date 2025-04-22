import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_frist_flutter_project/data/task_inherited.dart';
import 'package:my_frist_flutter_project/screens/form_screen.dart';
import 'package:my_frist_flutter_project/screens/initial_screen.dart';
import 'package:my_frist_flutter_project/services/tasks_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  TaskServices services = TaskServices();
  services.readAll();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodersolutions flutter app.',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          color: Colors.pink,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white, size:30)
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      // home: TaskInherited(child: InitialScreen()),
      initialRoute: "home",
      routes: {
        "home": (context) => TaskInherited(child: InitialScreen()),
        "form-screen": (context) => FormScreen(taskContext: context),
      },
      //home: FormScreen()
    );
  }
}
