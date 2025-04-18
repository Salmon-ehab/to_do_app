import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_app/core/errors/failure.dart';
import 'package:to_do_app/feature/authentication/data/repo/login_repo.dart';


class UserAuthRepoImplementaion implements UserAuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email'],);
      try {
        await googleSignIn.signOut();
      } catch (e) {
        print("Google sign-out failed: $e");
      }

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return left(Failure(error: "لم يتم اختيار حساب"));
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.idToken == null && googleAuth.accessToken == null) {
        return left(Failure(error: "Google فشل الحصول علي بيانات المصادقة"));
      }

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(authCredential);
      return right(userCredential);
    } on Exception catch (e) {
      print("Google sign-in error: $e");
      return Left(Failure(error: e.toString()));
    }
  }
}
