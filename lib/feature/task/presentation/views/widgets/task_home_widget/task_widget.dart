import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/core/assets/images.dart';
import 'package:to_do_app/core/assets/styles.dart';
import 'package:to_do_app/core/goRouter.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/menu_item.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/priority_row_widget.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget(
      {super.key,
      required this.image,
      required this.textTitle,
      required this.textDesc,
      required this.priority,
      required this.date,
      required this.taskId,
      required this.onDelete1,
      required this.progress});
  final String image;
  final String textTitle;
  final String textDesc;
  final String priority;
  final String progress;
  final String date;
  final String taskId;
  final Function(String) onDelete1; // دالة الحذف

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final Map<String, Color> priorityColors = {
    'High': ColorStyle.color12,
    'Medium': ColorStyle.splashColor,
    'Low': ColorStyle.color13,
  };
  final Map<String, Color> progressTextColors = {
    'Finished': ColorStyle.color13,
    'Inprogress': ColorStyle.splashColor,
    'Waiting': ColorStyle.color12,
  };
  final Map<String, Color> progressBackGroundColors = {
    'Finished': ColorStyle.color15,
    'Inprogress': ColorStyle.color10,
    'Waiting': ColorStyle.color14,
  };
  @override
  Widget build(BuildContext context) {
    final priorityColor = priorityColors[widget.priority] ?? Colors.grey;
    final progressTextColor = progressTextColors[widget.progress] ?? Colors.grey;
    final progressbackgroundColor = progressBackGroundColors[widget.progress] ?? Colors.grey;

    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRouter.taskDetailsScreen,
            extra: TaskWidget(
              image: widget.image,
              textTitle: widget.textTitle,
              textDesc: widget.textDesc,
              priority: widget.priority,
              date: widget.date,
              taskId: widget.taskId,
              onDelete1: widget.onDelete1,
              progress: widget.progress,
            ));
      },
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        color: ColorStyle.splashColorText1,
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.file(
              File(widget.image),
              height: 64,
              width: 64,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      SizedBox(
                          width: 135,
                          child: Text(
                            widget.textTitle,
                            style: Styles.text12,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                      Container(
                        height: 22,
                        width: 65,
                      //  padding: EdgeInsets.only(left: 2,right: 2),
                        decoration: BoxDecoration(
                          color: progressbackgroundColor,
                                borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(
                            widget.progress,
                            style:TextStyle(
                              color:progressTextColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.dmSans().fontFamily,

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                      width: 200,
                      child: Text(
                        widget.textDesc,
                        style: Styles.text19,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      PriorityRowWidget(
                          ptiorityName: widget.priority, color: priorityColor),
                      Text(widget.date, style: Styles.text22),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            MenuItem(
              taskId1: widget.taskId,
              onDelete: widget.onDelete1,
              upDate: (String) {},
            )
          ],
        ),
      ),
    );
  }
}
