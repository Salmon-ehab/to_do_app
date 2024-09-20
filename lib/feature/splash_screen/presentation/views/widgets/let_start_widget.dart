import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/core/assets/styles.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';

import '../../../../../core/assets/images.dart';
import '../../../../../core/goRouter.dart';

class LetStartWidget extends StatelessWidget {
  const LetStartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Container(
          height:600,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage( ImageStyle.imageApp,), // تأكد من إضافة الصورة في مجلد assets
              fit: BoxFit.cover, // لجعل الصورة تغطي الخلفية بالكامل
            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(bottom:50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 150.h,
                  width: 375.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width:250,
                        child: Text(
                          " Task Management & To-Do List",
                          style: Styles.text3,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width:250,
                        child: Text("This productive tool is designed to help you better manage your task project-wise conveniently!",
                          style: Styles.text4,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,

                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 15,),
             CustomButton(text: "Let’s Start", image: ImageStyle.arrow,onPressed: (){
               GoRouter.of(context).push(AppRouter.logInScreen);
             },)


            ],
          ),
        ),

      ],
    );
  }
}
