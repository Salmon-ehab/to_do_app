import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/widgets/custom_drop_down_button.dart';
import 'package:to_do_app/feature/authentication/data/firebase_data.dart';
import 'package:to_do_app/feature/authentication/presentation/views/widgets/custom_inkwell_text.dart';
import 'package:to_do_app/feature/authentication/presentation/views/widgets/custom_phone_number_field.dart';

import '../../../../../../core/assets/colors.dart';
import '../../../../../../core/assets/images.dart';
import '../../../../../../core/assets/styles.dart';
import '../../../../../../core/goRouter.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';

class SignUpBody extends StatefulWidget {
  SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  bool isClick = false;
  List<String> list = ['Senior', 'Junior'];
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController yearsOfExperienceController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool levelError = false;

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController;
    emailController;
    yearsOfExperienceController;
    levelController;
    addressController;
    passwordController;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: .7,
                  image: AssetImage(
                    ImageStyle.splashImage,
                  ), // تأكد من إضافة الصورة في مجلد assets
                  fit: BoxFit.cover, // لجعل الصورة تغطي الخلفية بالكامل
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 250, left: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign up",
                    style: Styles.text3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    hintText: 'Name...',
                    maxLines: 1,
                    textInputType: TextInputType.text,
                    height: 50.h,
                    width: 326.w,
                    Controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name.';
                      }
                      if (value.length < 5) {
                        return "Name must not be less than 5 characters.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
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
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    maxLines: 1,
                    hintText: 'Years of experience...',
                    textInputType: TextInputType.number,
                    height: 50.h,
                    width: 326.w,
                    Controller: yearsOfExperienceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter years of experience.';
                      }
                      final number =
                          int.tryParse(value); // نحاول تحويل المدخل إلى رقم
                      if (number == null) {
                        return 'Not Valid!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomDropDownButton(
                    list: list,
                    backgroundColor: ColorStyle.splashColorText1,
                    prefixIcon: null,
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                    hintText: 'Choose experience Level',
                    textStyle: Styles.text8,
                    iconColor: ColorStyle.color5,
                    Controller: levelController, width: 326,
                  ),
                  if (levelError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.5),
                      child: Text(
                        'Please choose a level.',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .error, // استخدام نفس اللون الافتراضي للخطأ
                          fontSize: 12.0, // حجم النص الافتراضي لرسالة الخطأ
                          fontWeight:
                          FontWeight.normal, // محاذاة نفس وزن الخط الافتراضي
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    hintText: 'Address...',
                    maxLines: 1,
                    textInputType: TextInputType.streetAddress,
                    height: 50.h,
                    width: 326.w,
                    Controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Address must not be empty";
                      }
                      if (value.length < 5) {
                        return "Address must not be less than 5 characters.";
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    hintText: 'Password...',
                    maxLines: 1,
                    obscureText: isClick,
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
                        return "Password must not be less than 8 characters.";
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
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Sign up",
                    image: null,
                    onPressed: () async {
                      setState(() {
                        levelError = levelController.text.isEmpty;
                      });
                      if (formKey.currentState!.validate() && !levelError) {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          await AuthManager().saveUserData(
                              name: nameController.text,
                              email: emailController.text,
                              experience:
                                  int.tryParse(yearsOfExperienceController.text),
                              level: levelController.text,
                              address: addressController.text,
                              password: passwordController.text);
                          if (userCredential.user != null) {
                            await AuthManager().saveUidToSharedPreference(
                                userCredential.user!.uid);
                            GoRouter.of(context).push(AppRouter.taskHomeScreen);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomInkwellText(
                      Text1: "Already have any account?",
                      Text2: "Sign in",
                      path: AppRouter.logInScreen)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
