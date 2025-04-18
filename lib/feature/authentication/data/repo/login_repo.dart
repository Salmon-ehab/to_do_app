import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/core/errors/failure.dart';

abstract class UserAuthRepo{
  Future<Either<Failure,UserCredential>> signInWithGoogle();
}