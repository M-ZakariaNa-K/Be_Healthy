import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';

class DefultButton extends StatelessWidget {
  const DefultButton({
    super.key,
    required this.buttonColor,
    required this.borderColor,
    @required this.textColor,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  final Color buttonColor;
  final Color? textColor;
  final Color borderColor;
  final String title;
  final dynamic icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppVar.borderradiusprimary + 30),
            side: BorderSide(color: borderColor, width: 2)),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const Text(''),
          Text(
            title,
            style: TextStyle(
                color: textColor ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? AppVar.seconndTextColor
                        : AppVar.textColor),
                fontSize: AppVar.littelFontSize),
          ),
        ],
      ),
    );
  }
}
