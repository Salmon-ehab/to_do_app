import 'package:flutter/material.dart';
import 'package:to_do_app/feature/authentication/presentation/views/widgets/sign_up_widget/sign_up_body.dart';

import '../../../../core/assets/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.splashColorText1,
      body: SignUpBody(),
    );
  }
}
