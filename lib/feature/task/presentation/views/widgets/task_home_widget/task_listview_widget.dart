import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/task_widget.dart';

import '../../../../../../core/assets/images.dart';
import '../../../../../../core/assets/styles.dart';
import '../../../../data/models/task_model.dart';

class TaskListviewWidget extends StatefulWidget {
  const TaskListviewWidget({super.key, required this.task, required this.onDELETE});
 final List<TaskFireBaseModel> task ;
  final Function(String) onDELETE;
  @override
  State<TaskListviewWidget> createState() => _TaskListviewWidgetState();
}

class _TaskListviewWidgetState extends State<TaskListviewWidget> {


  @override
  Widget build(BuildContext context) {
    return widget.task.length > 0
        ? SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.task.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskWidget(
                  image: widget.task[index].image,
                  textTitle: widget.task[index].textTitle,
                  textDesc: widget.task[index].textDesc,
                  priority: widget.task[index].priority,
                  date: widget.task[index].date,
                  taskId: widget.task[index].taskId,
                  onDelete1: widget.onDELETE,
                  progress: widget.task[index].progress,
                );
              })
        ],
      ),
    )
        : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(ImageStyle.lottie,
                height: 230, width: 180, fit: BoxFit.contain),
            SizedBox(height: 10), // مسافة بين الرسوم والنص
            Text(
              "There are no tasks. Add a task",
              style: Styles.text20,
            ),
          ],
        ));
  }
}
