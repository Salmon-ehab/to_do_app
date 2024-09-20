import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/menu_item.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/task_widget.dart';

import '../../../../../core/assets/colors.dart';
import '../../../../../core/assets/images.dart';
import '../../../../../core/assets/styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.headerText,
    required this.ActionIcon,
    this.onDelete,
    this.taskWidget,
    this.upDate,
  });
  final String headerText;
  final bool ActionIcon;
  final Function(String)? onDelete;
  final Function(String)? upDate;
  final TaskWidget? taskWidget;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      toolbarHeight: 100,
      titleSpacing: 0,
      backgroundColor: ColorStyle.splashColorText1,
      title: Text(
        headerText,
        style: Styles.text12,
      ),
      automaticallyImplyLeading: false,
      leading: Transform.rotate(
        angle: 3.14159,
        // 180 degrees in radians
        child: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: SvgPicture.asset(
            ImageStyle.arrow,
            color: ColorStyle.color7,
            height: 24, // Adjust height as needed
            width: 24,
            fit: BoxFit.scaleDown, // Ensure scaling fits
          ),
        ),
      ),
      actions: [
        taskWidget != null && onDelete != null
            ? MenuItem(
                taskId1: taskWidget!.taskId,
                onDelete: onDelete!,
                upDate: upDate!)
            // ? IconButton(
            //     onPressed: onPressed,
            //     icon: Image.asset(
            //       ImageStyle.menuIcon,
            //       height: 24, // Adjust height as needed
            //       width: 24,
            //       fit: BoxFit.contain,
            //     ))
            : SizedBox.shrink()
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
