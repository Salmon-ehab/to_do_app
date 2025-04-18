

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/feature/authentication/data/repo/login_repo_implementation.dart';
import 'package:to_do_app/feature/authentication/presentation/manager/login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  final UserAuthRepoImplementaion userAuthRepoImplementaion;
  LoginCubit( this.userAuthRepoImplementaion) :super(GoogleAuthInitialState());

  Future<void> loginWithGoogle() async{
    emit(GoogleAuthLoadingState());
    var userAuthWithGoogle = await userAuthRepoImplementaion.signInWithGoogle();
    userAuthWithGoogle.fold((ifLeft){
      emit(GoogleAuthFailureState(error: ifLeft.error));
    }, (ifRight){

      emit(GoogleAuthSuccessState());
    });

  }

}