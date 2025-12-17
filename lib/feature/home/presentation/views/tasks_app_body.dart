
import 'package:add_tasks/core/reuse/button_style.dart';
import 'package:add_tasks/core/theme/color.dart';
import 'package:add_tasks/database/db.dart';
import 'package:add_tasks/model/model.dart';
import 'package:flutter/material.dart';
import 'package:add_tasks/core/reuse/text_style.dart';

class TasksAppBody extends StatefulWidget {
  TasksAppBody({super.key});

  @override
  State<TasksAppBody> createState() => _TasksAppBodyState();
}

class _TasksAppBodyState extends State<TasksAppBody> {
  List<Model> listModel = [];

  final taskcontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  @override
  void dispose() {
    taskcontroller.dispose();
    descriptioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getTask(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10),
                color: AppColor.primarycolor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                     // task 
                      Text(
                        "Task ${snapshot.data![index].task}",
                        style: TextStyles.headline_1,
                      ),
                      SizedBox(width: 200),
                     // description
                      Text(
                        "Desciption : ${snapshot.data![index].description}",
                        style: TextStyles.headline_2,
                      ),

                       Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          // edit button
                        IconButton(
                        onPressed: () {
                          taskcontroller.text = snapshot.data![index].task;  //task before edit exist
                          descriptioncontroller.text = snapshot.data![index].description;
                           showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: EdgeInsets.all(10),
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // task
                  TextField(
                    controller: taskcontroller,
                    decoration: InputDecoration(
                      labelText: "task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //description
                  TextField(
                    controller: descriptioncontroller,
                    decoration: InputDecoration(
                      labelText: "description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //update
                  ElevatedButton(
                     style: ButtonStyles.text_button_style,
                    onPressed: () {
                       DatabaseHelper.instance.UpdateTask(
  Model(
    id: snapshot.data![index].id,
    task:   taskcontroller.text,
    description:  descriptioncontroller.text,
  ),
);
setState(() {});

                      Navigator.pop(context);
                    },
                    child: Text("Update", style:TextStyle(color:AppColor.secondcolor )),
                  ),
                ],
              ),
            ),
          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColor.secondcolor,
                        ),
                      ),

                      // delete button
                      IconButton(
                        onPressed: () {
                          DatabaseHelper.instance.deleteTask(
                            snapshot.data![index],
                          );
                          setState(() {});
                        },
                      
                        icon: Icon(
                          Icons.delete,
                          color: AppColor.secondcolor,
                        ),
                      ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator()); //if data is waiting
        }
      },
    );
  }
}
