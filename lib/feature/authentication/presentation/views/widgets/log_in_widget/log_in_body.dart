import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/goRouter.dart';
import 'package:to_do_app/feature/authentication/data/firebase_data.dart';
import 'package:to_do_app/feature/authentication/presentation/views/widgets/log_in_widget/social_media_button.dart';
import '../../../../../../core/assets/colors.dart';
import '../../../../../../core/assets/images.dart';
import '../../../../../../core/assets/styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../custom_inkwell_text.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({super.key});

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  bool isClick = false;
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void initState() {
    super.initState();
  }
  String? generalErrorMessage;
  String? emailErrorMessage;
  String? passwordErrorMessage;

  void setError({String? generalError, String? emailError, String? passwordError}) {
    setState(() {
      generalErrorMessage = generalError;
      emailErrorMessage = emailError;
      passwordErrorMessage = passwordError;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 700,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImageStyle.imageApp,
                  ), // تأكد من إضافة الصورة في مجلد assets
                  fit: BoxFit.cover, // لجعل الصورة تغطي الخلفية بالكامل
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 500, left: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: Styles.text3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (generalErrorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        generalErrorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  CustomTextFormField(
                    hintText: 'Email...',
                    maxLines: 1,
                    prefix: null,
                    textInputType: TextInputType.emailAddress,
                    height: 50.h,
                    width: 326.w,
                    Controller: emailController,
                    validator: (value) {
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Email must not be empty";
                      }
                      if (emailValid == false) {
                        return "Email format must be valid";
                      }
                      return null;
                    },
                  ),
                  if (emailErrorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        emailErrorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: 'Password...',
                    obscureText: isClick,
                    maxLines: 1,
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          isClick = !isClick;
                        });
                      },
                      child: isClick == false
                          ? Icon(
                              Icons.visibility_outlined,
                              color: ColorStyle.color3,
                            )
                          : Icon(
                              Icons.visibility_off_outlined,
                              color: ColorStyle.color3,
                            ),
                    ),
                    textInputType: TextInputType.text,
                    height: 50.h,
                    width: 326.w,
                    Controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password must not be empty";
                      }
                      if (value.length < 8) {
                        return "Password must not be less than 8";
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  if (passwordErrorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        passwordErrorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: "Sign In",
                    image: null,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setError(generalError: null, emailError: null, passwordError: null);

                        await AuthManager().signInWithEmailPassword(
                            emailController.text,
                            passwordController.text,
                            context,
                            setError
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomInkwellText(
                      Text1: "Didn’t have any account?",
                      Text2: "Sign Up here",
                      path: AppRouter.signUpScreen),
                      SocialMediaButtons()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
