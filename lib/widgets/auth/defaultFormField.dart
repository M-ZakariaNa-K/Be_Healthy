import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';

class DefaultFormFeild extends StatelessWidget {
  const DefaultFormFeild({
    super.key,
    required this.textEditingController,
    required this.validator,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.autoFoucs,
    this.onSubmitted,
    this.iniValue,
    this.textInputType,
    this.enable,
  });

  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final VoidCallback? onSubmitted;
  final String? hintText;
  final bool? obscureText;
  final Icon? prefixIcon;
  final bool? autoFoucs;
  final String? iniValue;
  final TextInputType? textInputType;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        onFieldSubmitted: (value) {
          if (onSubmitted != null) onSubmitted!();
        },
        controller: textEditingController,
        enableSuggestions: false,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: obscureText!,
        textInputAction: TextInputAction.next,
        cursorColor: AppVar.primary,
        validator: validator,
        autofocus: autoFoucs!,
        initialValue: iniValue,
        enabled: enable ?? true,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppVar.textColor.withAlpha(80),
                fontSize: AppVar.mainFontSize - 2),
            floatingLabelStyle: TextStyle(
              color: AppVar.primary,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppVar.primary.withAlpha(80),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppVar.primary,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppVar.primary,
                ))),
      ),
    );
  }
}
//custom

