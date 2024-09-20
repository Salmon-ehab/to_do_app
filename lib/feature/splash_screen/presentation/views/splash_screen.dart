import 'package:flutter/material.dart';
import 'package:to_do_app/feature/splash_screen/presentation/views/widgets/splash_widget.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashWidget(),
    );
  }
}
