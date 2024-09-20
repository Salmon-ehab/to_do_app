import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/core/goRouter.dart';
import 'package:to_do_app/feature/authentication/data/firebase_data.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/task_home_body.dart';

import '../../../../core/assets/styles.dart';

class TaskHomeScreen extends StatelessWidget {
  const TaskHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
          padding:  EdgeInsets.only(bottom: 30),
          child: Container(
            width: 65, // Set width for the FAB
            height: 65,
            child: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: ColorStyle.splashColor,
            elevation: 15, // Set the elevation for shadow
            onPressed: () {
              GoRouter.of(context).push(AppRouter.addTaskScreen);
            },
            child: Icon(
              Icons.add,
              color: ColorStyle.splashColorText1,
              size: 33,
            ),
                    ),
          ),
      ),
      appBar: AppBar(
        toolbarHeight: 100,
        scrolledUnderElevation: 0,
        backgroundColor: ColorStyle.splashColorText1,
        automaticallyImplyLeading: false,
        title: Text(
          "Logo",
          style: Styles.text3,
        ),
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.profileScreen);
              },
              icon: Icon(Icons.account_circle_outlined,
                  color: ColorStyle.color7)),
          IconButton(
              onPressed: () async{
                await  AuthManager().logOut(context);

              },
              icon: Icon(
                Icons.logout,
                color: ColorStyle.splashColor,
              )),
        ],
      ),
      backgroundColor: ColorStyle.splashColorText1,
      body: TaskHomeBody(),
    );
  }
}
