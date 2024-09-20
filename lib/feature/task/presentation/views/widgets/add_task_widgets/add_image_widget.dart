import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/core/assets/images.dart';
import '../../../../../../core/assets/colors.dart';
import '../../../../../../core/assets/styles.dart';

class AddImageWidget extends StatefulWidget {
  final TextEditingController controller; // Controller للحفظ

  AddImageWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _AddImageWidgetState createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
      // حفظ مسار الصورة في الـ controller
      if (pickedFile != null) {
        widget.controller.text = pickedFile.path; // حفظ مسار الصورة
      }
    });
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      widget.controller.clear(); // مسح الـ controller عند حذف الصورة
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: DottedBorder(
        color: ColorStyle.splashColor,
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        child: Container(
          height: _imageFile == null ? 56 : 220,
          width: 331,
          alignment: Alignment.center,
          child: _imageFile == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageStyle.imageAddIcon),
                    SizedBox(width: 8),
                    Text(
                      "Add Img",
                      style: Styles.text15,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Image.file(
                      File(_imageFile!.path),
                      height: 150,
                      width: 331,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _removeImage,
                      child: Text("Remove Image"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorStyle.splashColorText1,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
