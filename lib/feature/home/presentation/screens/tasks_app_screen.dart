import 'package:add_tasks/core/reuse/button_style.dart';
import 'package:add_tasks/core/reuse/text_style.dart';
import 'package:add_tasks/core/theme/color.dart';
import 'package:add_tasks/database/db.dart';
import 'package:add_tasks/feature/home/presentation/views/tasks_app_body.dart';
import 'package:add_tasks/model/model.dart';
import 'package:flutter/material.dart';

class TasksAppScreen extends StatefulWidget {
  TasksAppScreen({super.key});

  @override
  State<TasksAppScreen> createState() => _TasksAppScreenState();
}

class _TasksAppScreenState extends State<TasksAppScreen> {
  //controller
  final taskcontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  @override
  //dispose=>preformance
  void dispose() {
    taskcontroller.dispose();
    descriptioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondcolor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primarycolor,
        title: Text("Tasks", style: TextStyles.headline_1),
      ),
      // add button
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primarycolor,

        onPressed: () {
          ButtonStyles.icon_button_style; //style button
          taskcontroller.clear();    // clear data in text field
          descriptioncontroller.clear();

          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: EdgeInsets.all(10),
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //textfield=>task
                  TextField(
                    controller: taskcontroller,
                    decoration: InputDecoration(
                      labelText: "task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //textfield=> description
                  TextField(
                    controller: descriptioncontroller,
                    decoration: InputDecoration(
                      labelText: "description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  // create button
                  ElevatedButton(
                    style: ButtonStyles.text_button_style,
                  
                    onPressed: () {
                      // insert task & description
                      DatabaseHelper.instance.insertTask(
                        Model(
                          task: taskcontroller.text,
                          description: descriptioncontroller.text,
                        ),
                      );
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text("Create Now", style:TextStyle(color:AppColor.secondcolor ) ),
                  ),
                ],
              ),
            ),
          );
        },
        child: Icon(Icons.add, color: AppColor.secondcolor),
      ),
      body: TasksAppBody(),
    );
  }
}
