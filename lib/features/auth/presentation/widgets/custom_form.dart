import 'package:flutter/material.dart';
import 'package:nelta/common/app_const/app_color.dart';

class CustomTextformFormField extends StatelessWidget {
  const CustomTextformFormField({
    Key? key,
    this.istextCapitilization = false,
    this.hintText,
    this.suffixWidget,
    this.validator,
    this.enabledTextformField = true,
    this.isLableIconrequire = false,
    this.isFieldrequired = false,
    this.isLablerequire = false,
    this.ismaxLength = false,
    this.obscureText = false,
    this.issuffixIconrequired,
    this.iconData,
    this.label,
    required this.keyboardType,
    required this.controller,
    required this.textInputAction,
  }) : super(key: key);
  final String? label;
  final String? hintText;
  final bool? enabledTextformField;
  final bool? isFieldrequired;
  final Widget? issuffixIconrequired;
  final bool ismaxLength;
  final IconData? iconData;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool isLableIconrequire;
  final bool isLablerequire;
  final bool istextCapitilization;
  final bool obscureText;
  final Widget? suffixWidget;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    var enabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(
          width: 0.5,
          // color: Color(0xff575757),
          color: Color(0xffF1F1F1)),
      borderRadius: BorderRadius.circular(4.0),
    );
    var errorBoder = OutlineInputBorder(
      borderSide: BorderSide(
          width: 0.5,
          // color: Color(0xff575757),
          color: AppColorResources.textRed),
      borderRadius: BorderRadius.circular(4.0),
    );
    // final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isLablerequire ? 10 : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: obscureText,
              textCapitalization: istextCapitilization
                  ? TextCapitalization.words
                  : TextCapitalization.none,
              validator: validator,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              maxLength: ismaxLength ? 10 : null,
              enabled: enabledTextformField,
              textInputAction: textInputAction,
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                counterText: "",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                suffix: suffixWidget,
                hintText: hintText,
                suffixIcon: issuffixIconrequired,
                fillColor: const Color(0xffF1F1F1),
                filled: true,
                border: enabledBorder,
                enabledBorder: enabledBorder,
                errorBorder: errorBoder,
                focusedErrorBorder: errorBoder,
                focusedBorder: enabledBorder,
                disabledBorder: enabledBorder,
              )),
        ],
      ),
    );
  }
}
