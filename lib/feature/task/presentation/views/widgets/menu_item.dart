import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/assets/styles.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.taskId1,
      required this.onDelete,
      required this.upDate});
  final String taskId1;
  final Function(String) onDelete; // دالة الحذف
  final Function(String) upDate; // دالة الحذف

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      color: Colors.white, // لون الخلفية أبيض
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // نصف قطر الحواف 10
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit",
                style: Styles.text20,
              ),
              Divider(
                thickness: .8,
              )
            ],
          ),
        ),
        PopupMenuItem(
          height: 30,
          value: 2,
          child: Text("Delete", style: Styles.text21),
        ),
      ],
      onSelected: (value) async {
        if (value == 1) {
          await upDate(taskId1); // استدعاء دالة الحذف
        }
        if (value == 2) {
          await onDelete(taskId1); // استدعاء دالة الحذف
        }
      },
    );
  }
}
