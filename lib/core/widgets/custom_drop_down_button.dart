import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/colors.dart';
import '../assets/styles.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    super.key,
    required this.list,
    required this.backgroundColor,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.textStyle,
    required this.iconColor,
    this.Controller,
    this.rowText,
    this.isEnabled = true,
    this.Text2, required this.width, // إضافة خاصية isEnabled
  });

  final List<String>? list;
  final Color backgroundColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final String? rowText;
  final String? Text2;
  final double width;

  final TextStyle textStyle;
  final Color? iconColor;
  final TextEditingController? Controller;
  final bool? isEnabled; // خاصية للتحكم في التفعيل

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? dropdownValue;

  void initState() {
    super.initState();
    dropdownValue = widget.Controller?.text.isNotEmpty == true ? widget.Controller!.text : null;

    // if (widget.Controller != null) {
    //   widget.Controller!.text = dropdownValue ?? '';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 331.w,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.backgroundColor,
        border: Border.all(color: ColorStyle.color3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.prefixIcon != null ? widget.prefixIcon! : SizedBox.shrink(),
          widget.prefixIcon != null
              ? SizedBox(
                  width: 10,
                )
              : SizedBox.shrink(),
          SizedBox(
            height: 50.h,
            width: widget.prefixIcon != null ? 265.w : 290,
            child: AbsorbPointer(
              absorbing:
                  !widget.isEnabled!, // إيقاف التفاعل بناءً على isEnabled
              child: DropdownButton<String>(
                hint: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  widget.Text2 !=null?  Text(
                      widget.Text2!,
                      style: Styles.text24,
                    ):SizedBox.shrink(),
                    widget.Text2 !=null? SizedBox(height: 5,):SizedBox.shrink(),
                    Text(
                      widget.hintText,
                      style: widget.textStyle,
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                underline: Divider(
                  thickness: 0,
                  color: widget.backgroundColor,
                ),
                isExpanded: true,
                value: dropdownValue,
                icon: widget.suffixIcon,
                elevation: 16,
                style: widget.textStyle,
                onChanged: widget.isEnabled!
                    ? (String? value) {
                        // تغيير التفاعل بناءً على isEnabled
                        setState(() {
                          dropdownValue = value;
                          if (widget.Controller != null) {
                            widget.Controller!.text = dropdownValue ?? '';
                          }
                        });
                      }
                    : null,
                items:
               widget.list?.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Text(value),
                       const SizedBox(
                          width: 5,
                        ),
                        widget.rowText != null
                            ? Text(widget.rowText!)
                            : SizedBox.shrink(),
                      ],
                    ),
                  );
                }).toList()
              ),
            ),
          ),
        ],
      ),
    );
  }
}
