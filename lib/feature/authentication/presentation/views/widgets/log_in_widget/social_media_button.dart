import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/goRouter.dart';
import 'package:to_do_app/feature/authentication/presentation/manager/login_cubit.dart';
import 'package:to_do_app/feature/authentication/presentation/manager/login_state.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccessState) {
          GoRouter.of(context).push(AppRouter.taskHomeScreen);
        } else if (state is GoogleAuthFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        bool isLoading = state is GoogleAuthLoadingState;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.accessibility_sharp),
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<LoginCubit>().loginWithGoogle();
                    },
            ),
          ],
        );
      },
    );
  }
}
