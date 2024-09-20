import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/assets/colors.dart';

import '../../../../../core/assets/styles.dart';
import '../../../../../core/goRouter.dart';
import '../../../../authentication/data/firebase_data.dart';

class SplashWidget extends StatefulWidget {
  SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  final AuthManager authManager = AuthManager();

  @override

  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   authManager.checkLogIn(context);  // استخدام context بشكل صحيح
    // });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // لعرض الشاشة كاملة بدون شريط الاشعارات
    Future.delayed( Duration(seconds: 4), () {
      GoRouter.of(context).push(AppRouter.letStartScreen);
    });
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values);  // نرجع شريط الحالة والتنقل
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: ColorStyle.splashColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Task", style: Styles.text1),
          Text("y", style: Styles.text2)
        ],
      ),
    );
  }
}
