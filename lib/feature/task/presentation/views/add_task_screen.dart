import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/add_task_widgets/add_task_body.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/custom_appBar.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(headerText: "Add new task", ActionIcon: false),
      backgroundColor: ColorStyle.splashColorText1,
      body: AddTaskBody(),
    );
  }
}
