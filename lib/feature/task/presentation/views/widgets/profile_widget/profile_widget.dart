import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/assets/colors.dart';
import 'package:to_do_app/core/assets/styles.dart';

class ProfileWidget extends StatelessWidget {
   ProfileWidget(
      {super.key, required this.text1, required this.text2, this.icon, this.onPressed});
  final String text1;
  final String text2;
  final Widget? icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      height: 68,
      width: 326,
      decoration: BoxDecoration(
          color: ColorStyle.color9, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: Styles.text13,
              ),
              Text(
                text2,
                style: Styles.text14,
              )
            ],
          ),
          icon != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed:onPressed,
                      icon: icon!,
                    ),
                  ],
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
