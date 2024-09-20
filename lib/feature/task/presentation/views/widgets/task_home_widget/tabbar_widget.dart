import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/core/assets/styles.dart';
import 'package:to_do_app/feature/task/data/firebase_tasks_data/tasks_data.dart';
import 'package:to_do_app/feature/task/data/models/task_model.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/task_listview_widget.dart';

class TabbarWidget extends StatefulWidget {
  TabbarWidget({super.key});

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget> {
  List<TaskFireBaseModel> allTasks = [];
  List<TaskFireBaseModel> inProgressTask = [];
  List<TaskFireBaseModel> waitingTask = [];
  List<TaskFireBaseModel> finishedTask = [];

  @override
  void initState() {
    super.initState();
    getTask();
  }

  Future getTask() async {
    allTasks = await TaskService().getTasksFromFirebase();
    inProgressTask = await TaskService().getTasksFromFirebase(progress: "Inprogress");
    waitingTask = await TaskService().getTasksFromFirebase(progress: "Waiting");
    finishedTask = await TaskService().getTasksFromFirebase(progress: "Finished");
      print(allTasks);
      print(inProgressTask);
      print(waitingTask);
    setState(() {});
  }

  deleteTask(String taskId) async {
    try {
      await FirebaseFirestore.instance.collection("tasks").doc(taskId).delete();
      setState(() {
        allTasks.removeWhere((task) => task.taskId == taskId);
        setState(() {}); // إزالة العنصر من القائمة
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete item: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: ButtonsTabBar(
              radius: 24,
              contentPadding:
                  EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              buttonMargin: EdgeInsets.only(right: 15),
              backgroundColor: ColorStyle.splashColor,
              unselectedBackgroundColor: Colors.grey[300],
              unselectedLabelStyle: Styles.text10,
              labelStyle: Styles.text11,
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Inpogress",
                ),
                Tab(
                  text: "Waiting",
                ),
                Tab(
                  text: "Finished",
                ),
              ],
            ),
          ),
          Container(
            height: 580,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
              children: <Widget>[
                TaskListviewWidget(task: allTasks, onDELETE: deleteTask),
                TaskListviewWidget(task: inProgressTask, onDELETE: deleteTask),
                TaskListviewWidget(task: waitingTask, onDELETE: deleteTask),
                TaskListviewWidget(task: finishedTask, onDELETE: deleteTask),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
