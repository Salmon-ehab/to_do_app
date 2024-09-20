import 'package:flutter/material.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/feature/splash_screen/presentation/views/widgets/let_start_widget.dart';

class LetStartScreen extends StatelessWidget {
  const LetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.splashColorText1,
      body: LetStartWidget(),
    );
  }
}
