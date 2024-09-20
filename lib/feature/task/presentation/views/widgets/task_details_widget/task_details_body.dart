import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/core/assets/images.dart';
import 'package:to_do_app/core/assets/styles.dart';
import 'package:to_do_app/core/goRouter.dart';
import 'package:to_do_app/core/widgets/custom_drop_down_button.dart';
import 'package:to_do_app/core/widgets/custom_text_form_field.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/task_widget.dart';

class TaskDetailsBody extends StatefulWidget {
  const TaskDetailsBody(
      {super.key, required this.taskWidget1, required this.isEditable});
  final TaskWidget taskWidget1;
  final bool isEditable;

  @override
  State<TaskDetailsBody> createState() => _TaskDetailsBodyState();
}

class _TaskDetailsBodyState extends State<TaskDetailsBody> {
  List<String> progress = ['Finished', 'Inprogress', 'Waiting'];
  List<String> priority = ['High', 'Medium', 'Low'];

  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController progressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskWidget1.textTitle;
    descController.text = widget.taskWidget1.textDesc;
    priorityController.text = widget.taskWidget1.priority;
    progressController.text = widget.taskWidget1.progress;
    selectedDate = DateFormat('d/M/yyyy').parse(widget.taskWidget1.date);
  }

  void _updateTask() async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.taskWidget1.taskId)
        .update({
      'taskTitle': titleController.text,
      'taskDesc': descController.text,
      'date': DateFormat('d/M/yyyy').format(selectedDate),
      'priority': priorityController.text,
      'progress': progressController.text
    });
    setState(() {});
    print(priorityController.text);
    print(progressController.text);
    GoRouter.of(context).pushReplacement(AppRouter.taskHomeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(widget.taskWidget1.image),
                height: 225,
                width: 375,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 15),
              widget.isEditable
                  ? CustomTextFormField(
                      hintText: 'Enter title here...',
                      textInputType: TextInputType.text,
                      height: 50,
                      width: 331,
                      Controller: titleController,
                    )
                  : Text(
                      "${widget.taskWidget1.textTitle}",
                      style: Styles.text3,
                    ),
              SizedBox(height: 15),
              SizedBox(
                  width: 375,
                  child: widget.isEditable
                      ? CustomTextFormField(
                          hintText: 'Enter description here...',
                          textInputType: TextInputType.text,
                          height: 170,
                          width: 331,
                          maxLines: 10,
                          Controller: descController,
                        )
                      : Text(
                          "${widget.taskWidget1.textDesc}",
                          style: Styles.text19,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        )),
              SizedBox(height: 15),
              CustomDropDownButton(
                list: null,
                backgroundColor: ColorStyle.color10,
                hintText: DateFormat('d/M/yyyy').format(selectedDate),
                Text2: "End Date",
                textStyle: Styles.text25,
                isEnabled: widget.isEditable,
                suffixIcon: InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate; // تحديث التاريخ
                      });
                    }
                  },
                  child: SvgPicture.asset(ImageStyle.dateIcon,color:widget.isEditable ?ColorStyle.splashColor :Colors.grey ,),
                ),
                iconColor:widget.isEditable ?ColorStyle.splashColor :Colors.grey,
                width: 326,
              ),
              SizedBox(height: 15),
              CustomDropDownButton(
                list: progress,
                backgroundColor: ColorStyle.color10,
                hintText: progressController.text,
                textStyle: Styles.text17,
                iconColor: ColorStyle.splashColor,
                suffixIcon: Icon(Icons.arrow_drop_down_rounded,
                  color: widget.isEditable ?ColorStyle.splashColor :Colors.grey,),
                prefixIcon: null,
                isEnabled: widget.isEditable,
                Controller: progressController,
                width: 326,
              ),
              SizedBox(height: 15),
              CustomDropDownButton(
                list: priority,
                backgroundColor: ColorStyle.color10,
                prefixIcon: SvgPicture.asset(ImageStyle.flagIcon,color: widget.isEditable ?ColorStyle.splashColor :Colors.grey,),
                hintText: "${priorityController.text} Priority",
                textStyle: Styles.text17,
                iconColor: ColorStyle.splashColor,
                suffixIcon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: widget.isEditable ?ColorStyle.splashColor :Colors.grey,                ),
                isEnabled: widget.isEditable,
                Controller: priorityController,
                width: 326,
              ),
              SizedBox(height: 15),
              widget.isEditable
                  ? Center(
                    child: ElevatedButton(
                        onPressed: _updateTask,
                        child: Text('Save'),
                      ),
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
