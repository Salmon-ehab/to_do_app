import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/custom_appBar.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_details_widget/task_details_body.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/task_widget.dart';
import '../../../../core/goRouter.dart';
import '../../data/firebase_tasks_data/tasks_data.dart';
import '../../data/models/task_model.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskWidget taskWidget;

  const TaskDetailsScreen({
    Key? key,
    required this.taskWidget,
  }) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  List<TaskFireBaseModel> task = [];
  bool isEditable2 = false; // متغير لتتبع حالة التحرير

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  getTasks() async {
    task = await TaskService().getTasksFromFirebase();
    setState(() {});
  }

  deleteTask(String taskId) async {
    try {
      await FirebaseFirestore.instance.collection("tasks").doc(taskId).delete();
      setState(() {
        task.removeWhere((task) => task.taskId == taskId);
        GoRouter.of(context).pushReplacement(AppRouter.taskHomeScreen);
        setState(() {});
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
  void toggleEditMode(String taskId) {
    setState(() {
      isEditable2 = !isEditable2;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.splashColorText1,
      appBar: CustomAppbar(
          headerText: "Task Details",
          ActionIcon: true,
        taskWidget: widget.taskWidget,
        onDelete: deleteTask,
        upDate: toggleEditMode,
          ),
      body: TaskDetailsBody(
        taskWidget1: widget.taskWidget, isEditable: isEditable2,
      ),
    );
  }
}
