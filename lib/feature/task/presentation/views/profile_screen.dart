import 'package:flutter/material.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/custom_appBar.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/profile_widget/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(headerText: "Profile", ActionIcon: false,),
      backgroundColor: ColorStyle.splashColorText1,
       body: ProfileBody(),
    );
  }
}
