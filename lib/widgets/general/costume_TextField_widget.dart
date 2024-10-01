import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';

class CustomeTextFormField extends StatefulWidget {
  CustomeTextFormField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.title,
    required this.controller,
    required this.validator,
    @required this.prefixIcon,
  }) : super(key: key);

  final String hintText;
  final String title;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  @override
  State<CustomeTextFormField> createState() => _CustomeTextFormFieldState();
}

class _CustomeTextFormFieldState extends State<CustomeTextFormField> {
  bool _isPasswordVisible = false;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //1
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 15.0),
        //   child: Text(
        //     title,
        //     style: const TextStyle(
        //       color: ThemesStyles.textColor,
        //       fontWeight: FontWeight.w500,
        //       fontSize: 18.0,
        //     ),
        //   ),
        // ),
        //2
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          keyboardType: widget.inputType,
          obscureText:
              widget.title == "Password" && !_isPasswordVisible ? true : false,
          cursorColor: AppVar.primary, // Change cursor color
          style: TextStyle(
            color: AppVar.textColor, // Change text color
            fontSize: AppVar.littelFontSize, // Change text font size
          ),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            //  widget.title == "Password"
            //     ? const Icon(Icons.lock)
            //     :widget.title == "Email"? const Icon(Icons.email):null,
            suffixIcon: widget.title == "Password"
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )
                : null,
            fillColor: _isFocused
                ? AppVar.primary
                : Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xff2B2B2B)
                    : const Color(0xff5555),
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                color: Color.fromARGB(71, 105, 105, 105), fontSize: 16),

            // Customize the border color and radius
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
              borderRadius:
                  BorderRadius.circular(AppVar.borderradiusprimary + 5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppVar.primary, width: 2.0),
              borderRadius:
                  BorderRadius.circular(AppVar.borderradiusprimary + 5),
            ),
            // Adjust the height of the TextField using contentPadding
            contentPadding: const EdgeInsets.all(15.0),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
