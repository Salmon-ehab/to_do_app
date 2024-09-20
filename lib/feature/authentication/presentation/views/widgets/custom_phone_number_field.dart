import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class CustomPhoneNumberField extends StatefulWidget {
  final ValueChanged<CountryCode?>? onChanged; // هنا تم تعديل النوع ليقبل القيم الفارغة
  final String? initialSelection;
  final List<String>? favorite;
  final List<String>? countryFilter;
  final bool showFlagDialog;
  ValueChanged<CountryCode?>? onInit;
  final BoxDecoration? flagDecoration;

  CustomPhoneNumberField({
    Key? key,
    this.onChanged,
    this.initialSelection,
    this.favorite,
    this.countryFilter,
    this.showFlagDialog = true,
    this.onInit,
    this.flagDecoration,
  }) : super(key: key);

  @override
  _CustomPhoneNumberFieldState createState() => _CustomPhoneNumberFieldState();
}

class _CustomPhoneNumberFieldState extends State<CustomPhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: widget.onChanged,
      initialSelection: "EG", // Set the initial selection to Egypt
      favorite: widget.favorite ?? [],
      countryFilter: widget.countryFilter,
      showFlagDialog: widget.showFlagDialog,
      // comparator: widget.comparator,
      onInit: widget.onInit,
      flagDecoration: widget.flagDecoration,
    );
  }
}