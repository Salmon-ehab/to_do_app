import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/feature/authentication/presentation/views/log_in_screen.dart';
import 'package:to_do_app/feature/authentication/presentation/views/sign_up_screen.dart';
import 'package:to_do_app/feature/splash_screen/presentation/views/let_start_screen.dart';
import 'package:to_do_app/feature/task/presentation/views/add_task_screen.dart';
import 'package:to_do_app/feature/task/presentation/views/profile_screen.dart';
import 'package:to_do_app/feature/task/presentation/views/task_details_screen.dart';
import 'package:to_do_app/feature/task/presentation/views/task_home_screen.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/task_widget.dart';

import '../feature/splash_screen/presentation/views/splash_screen.dart';

abstract class AppRouter {
  static const letStartScreen = "/LetStartScreen";
  static const logInScreen = "/LogInScreen";
  static const signUpScreen = "/SignUpScreen";
  static const taskHomeScreen = "/TaskHomeScreen";
  static const profileScreen = "/ProfileScreen";
  static const addTaskScreen = "/AddTaskScreen";
  static const taskDetailsScreen = "/TaskDetailsScreen";


  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: letStartScreen,
      builder: (BuildContext context, GoRouterState state) {
        return LetStartScreen();
      },
    ),
    GoRoute(
      path: logInScreen,
      builder: (BuildContext context, GoRouterState state) {
        return LogInScreen();
      },
    ),
    GoRoute(
      path: signUpScreen,
      builder: (BuildContext context, GoRouterState state) {
        return SignUpScreen();
      },
    ),
    GoRoute(
      path: taskHomeScreen,
      builder: (BuildContext context, GoRouterState state) {
        return TaskHomeScreen();
      },
    ),
    GoRoute(
      path: profileScreen,
      builder: (BuildContext context, GoRouterState state) {
        return ProfileScreen();
      },
    ),
    GoRoute(
      path: addTaskScreen,
      builder: (BuildContext context, GoRouterState state) {
        return AddTaskScreen();
      },
    ),
    GoRoute(
      path: taskDetailsScreen,
      builder: (BuildContext context, GoRouterState state) {
        return TaskDetailsScreen(taskWidget: state.extra as TaskWidget,);
      },
    ),
  ]);
}
