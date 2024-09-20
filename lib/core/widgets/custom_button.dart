import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../assets/colors.dart';
import '../assets/styles.dart';
import '../goRouter.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key, required this.text, required this.image, this.onPressed});
 final String text;
  final String? image;
  final Function()?  onPressed;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 55.h,
      width: 326.w,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: ColorStyle.splashColor,

      ),
      child: MaterialButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text, style: Styles.text5),
              SizedBox(width: 7.w),
              image != null? SvgPicture.asset(image!,color: ColorStyle.splashColorText1,):SizedBox.shrink(),
            ],
          )),
    );
  }
}
