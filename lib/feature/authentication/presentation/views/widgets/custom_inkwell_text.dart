import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/assets/styles.dart';

class CustomInkwellText extends StatelessWidget {
  const CustomInkwellText({super.key, required this.Text1, required this.Text2, required this.path});
   final String Text1;
  final String Text2;
  final String path;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Text(Text1,style: Styles.text6,),
        SizedBox(width: 5.w,),
        InkWell(
            onTap:(){
              GoRouter.of(context).push(path);

            },
            child: Text(Text2,style: Styles.text7,))
      ],
    )
    ;
  }
}
