import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/core/assets/images.dart';
import 'package:to_do_app/core/assets/styles.dart';
import 'package:to_do_app/core/goRouter.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/add_task_widgets/add_image_widget.dart';

import '../../../../../../core/widgets/custom_drop_down_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';

class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key});

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  List<String> list = ['High', 'Medium', 'Low'];
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  int numberTask = 0;
  bool imageError = false;
  bool priorityError = false;
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    taskTitleController.dispose();
    taskDescController.dispose();
    priorityController.dispose();
    dateController.dispose();
    imageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddImageWidget(
                controller: imageController,
              ),
              if (imageError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.5),
                  child: Text(
                    'Please add an image.',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .error, // استخدام نفس اللون الافتراضي للخطأ
                      fontSize: 12.0, // حجم النص الافتراضي لرسالة الخطأ
                      fontWeight:
                          FontWeight.normal, // محاذاة نفس وزن الخط الافتراضي
                    ),
                  ),
                ),
              SizedBox(height: 10),
              Text("Task title", style: Styles.text16),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'Enter title here...',
                textInputType: TextInputType.text,
                height: 50,
                width: 331,
                Controller: taskTitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title.';
                  }
                  if (value.length < 5) {
                    return "task title must not be less than 5 characters.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text("Task Description", style: Styles.text16),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'Enter description here...',
                textInputType: TextInputType.text,
                height: 170,
                width: 331,
                maxLines: 10,
                Controller: taskDescController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task description.';
                  }
                  if (value.length < 20) {
                    return "task description must not be less than 20 characters.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text("Priority", style: Styles.text16),
              SizedBox(height: 10),
              CustomDropDownButton(
                list: list,
                backgroundColor: ColorStyle.color10,
                prefixIcon: SvgPicture.asset(
                  ImageStyle.flagIcon,
                  color: ColorStyle.splashColor,
                ),
                suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                rowText: "Priority",
                hintText: 'Choose Priority',
                textStyle: Styles.text17,
                iconColor: ColorStyle.splashColor,
                Controller: priorityController, width: 345,
              ),
              if (priorityError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.5),
                  child: Text(
                    'Please choose a priority.',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .error, // استخدام نفس اللون الافتراضي للخطأ
                      fontSize: 12.0, // حجم النص الافتراضي لرسالة الخطأ
                      fontWeight:
                          FontWeight.normal, // محاذاة نفس وزن الخط الافتراضي
                    ),
                  ),
                ),
              SizedBox(height: 15),
              Text("Due date", style: Styles.text16),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: "Choose due date",
                textInputType: TextInputType.datetime,
                height: 50,
                width: 331,
                suffix: IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        selectedDate = pickedDate;

                        String formattedDate =
                            DateFormat('d/M/yyyy').format(pickedDate);
                        dateController.text = formattedDate;
                      }
                    }, // تحديث النص

                    icon: SvgPicture.asset(ImageStyle.dateIcon)),
                Controller: dateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please choose a due date.';
                  }
                  return null;
                },
                readOnly: true, // جعل الحقل غير قابل للتعديل
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Add task",
                image: null,
                onPressed: () async {
                  setState(() {
                    numberTask++;
                    imageError = imageController.text.isEmpty;
                    priorityError = priorityController.text.isEmpty;
                  });
                  if (formKey.currentState!.validate() &&
                      !imageError &&
                      !priorityError) {
                    final taskDoc =
                        FirebaseFirestore.instance.collection("tasks").doc();

                    final taskMap = {
                      "image": imageController.text,
                      "taskTitle": taskTitleController.text,
                      "taskDesc": taskDescController.text,
                      "priority": priorityController.text,
                      "progress" :"Waiting",
                      "date": dateController.text,
                      "id": FirebaseAuth.instance.currentUser!.uid
                    };
                    await taskDoc.set(taskMap);
                    GoRouter.of(context).push(AppRouter.taskHomeScreen);
                  }
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
