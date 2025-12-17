import 'package:add_tasks/database/db.dart';
import 'package:add_tasks/task_app.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.initdb();
  runApp(TaskApp());
}
