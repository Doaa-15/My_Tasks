import 'package:add_tasks/feature/home/presentation/screens/tasks_app_screen.dart';
import 'package:flutter/material.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksAppScreen(),
    );
  }
}