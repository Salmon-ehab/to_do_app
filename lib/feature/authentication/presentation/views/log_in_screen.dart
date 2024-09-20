import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/feature/authentication/presentation/views/widgets/log_in_widget/log_in_body.dart';

import '../../../../core/assets/colors.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: ColorStyle.splashColorText1,

      body: LogInBody(),
    );
  }
}
