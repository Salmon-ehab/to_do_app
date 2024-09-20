import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/colors.dart';
import '../assets/styles.dart';
import '../../feature/authentication/presentation/views/widgets/custom_phone_number_field.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
     this.hintText,
    required this.textInputType,
    required this.height,
    required this.width,
    this.prefix,
    this.suffix,
    this.maxLines,
    this.obscureText,
    this.Controller,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.readOnly = false,
  });
  final String? hintText;
  final TextInputType textInputType;
  final bool? obscureText;
  final double height;
  final double width;
  final Widget? prefix;
  final Widget? suffix;
  int? maxLines;
  final TextEditingController? Controller;
  final FormFieldValidator<String>? validator;
  final Function(dynamic value)? onFieldSubmitted;
  final Function(dynamic value)? onChanged;
  bool? readOnly;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      constraints: BoxConstraints(
        minHeight: widget.height,
      ),
      child: TextFormField(
        readOnly: widget.readOnly ?? widget.readOnly!,
        controller: widget.Controller,
        validator: widget.validator,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText ?? false,
        cursorColor: ColorStyle.color3,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
            fillColor: ColorStyle.splashColorText1,
            filled: true,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.r),
              borderSide: BorderSide(
                color: ColorStyle.color3,
                width: 1.w,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: Styles.text6,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  13.r), // الحفاظ على الشكل عند التركيز والخطأ
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  13.r), // الحفاظ على الشكل عند التركيز والخطأ
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.r),
              borderSide: BorderSide(
                color: ColorStyle.color2,
                width: 1.5.w,
              ),
            )),
      ),
    );
  }
}
