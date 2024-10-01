import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tracking_system_app/style/app_var.dart';

String tr(String? en) {
  if (en == null) return '';
  if (AppVar.trArr.containsKey(en)) {
    return AppVar.trArr[en]!;
  }
  return en;
}

Text text01(String? str,
    {TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines}) {
  var adds = '';
  if (AppVar.LANG_CODE == 'ar') {
    style = TextStyle(
        color: style == null ? null : style.color,
        fontSize: style == null ? null : style.fontSize,
        fontWeight: style == null ? null : style.fontWeight,
        fontFamily: 'Almarai');
  }
  if (str != null &&
      str.isNotEmpty  &&
      (str.lastIndexOf(':') == (str.length - 1))) {
    str = str.substring(0, str.length - 1);
    adds = ':';
  }
  return Text(
    tr(str) + adds,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
  );
}

TextStyle hintStyle01({Color? color}) {
  if (AppVar.LANG_CODE == 'ar') {
    return TextStyle(fontFamily: 'Almarai', color: color);
  } else
    return TextStyle();
}

String formatTime({required TimeOfDay t}) {
  return "${t.hourOfPeriod}:${t.minute} ${tr(t.period.toString().split('.')[1])}";
}

String formatTime24({required TimeOfDay t}) {
  return "${t.hour}:${t.minute}:00";
}

String formatDateTime(DateTime dateTime, String pattern) {
  pattern = pattern.replaceAll('MMM', '554343');
  pattern = pattern.replaceAll('a', '5543467');
  final str = intl.DateFormat(pattern).format(dateTime);
  return str
      .replaceAll('554343', tr(intl.DateFormat('MMM').format(dateTime)))
      .replaceAll('5543467', tr(intl.DateFormat('a').format(dateTime)));
}

TextField TextField01({
  TextEditingController? controller,
  required InputDecoration decoration,
  TextDirection? textDirection,
  TextInputType? keyboardType,
  int? minLines,
  int? maxLines,
  Function(String s)? onChanged,
  bool? autofocus,
  TextStyle? style,
  FocusNode? focusNode,
  Function? onSubmitted,
  bool? obscureText,
  TextInputAction? textInputAction,
  bool? enabled,
  TextAlign? textAlign,
}) {
  return TextField(
    style: style,
    minLines: minLines ?? 1,
    maxLines: maxLines ?? 1,
    onTap: () {
      if (controller!.selection ==
          TextSelection.fromPosition(
              TextPosition(offset: controller.text.length - 1))) {
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    },
    textDirection: textDirection ??
        (AppVar.LANG_CODE == 'ar' ? TextDirection.rtl : TextDirection.ltr),
    keyboardType: keyboardType ?? TextInputType.text,
    controller: controller,
    decoration: decoration,
    onChanged: onChanged,
    autofocus: autofocus ?? false,
    focusNode: focusNode,
    onSubmitted: onSubmitted as void Function(String)?,
    obscureText: obscureText ?? false,
    textInputAction: textInputAction,
    enabled: enabled ?? true,
    textAlign: textAlign ?? TextAlign.start,
  );
}
