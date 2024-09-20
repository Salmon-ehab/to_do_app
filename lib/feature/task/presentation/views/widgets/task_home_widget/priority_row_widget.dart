import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/assets/images.dart';

class PriorityRowWidget extends StatelessWidget {
  const PriorityRowWidget(
      {super.key, required this.ptiorityName, required this.color});
  final String ptiorityName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(ImageStyle.flagIcon, color: color,height: 18,width: 18,),
        SizedBox(
          width: 5,
        ),
        Text(ptiorityName,
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.dmSans().fontFamily,
            ))
      ],
    );
  }
}
