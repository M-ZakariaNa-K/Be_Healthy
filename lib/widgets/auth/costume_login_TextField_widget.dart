// import 'package:flutter/material.dart';
// import 'package:tracking_system_app/style/app_var.dart';

// class CustomeLoginTextFormField extends StatefulWidget {
//   const CustomeLoginTextFormField({
//     Key? key,
//     required this.hintText,
//     required this.inputType,
//     required this.title,
//     required this.controller,
//     required this.validator,
//     @required this.prefixIcon,
//     @required this.isFilledTextFild,
//     @required this.filledTextFildData,
//   }) : super(key: key);

//   final String hintText;
//   final String title;
//   final TextInputType inputType;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final Widget? prefixIcon;
//   final bool? isFilledTextFild;
//   final String? filledTextFildData;
//   @override
//   State<CustomeLoginTextFormField> createState() =>
//       _CustomeLoginTextFormFieldState();
// }

// class _CustomeLoginTextFormFieldState extends State<CustomeLoginTextFormField> {
//   bool _isPasswordVisible = false;
//   final FocusNode _focusNode = FocusNode();
//   bool _isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() {
//       setState(() {
//         _isFocused = _focusNode.hasFocus;
//       });
//     });
//     if (widget.isFilledTextFild != null) {
//       widget.controller.text = "${widget.filledTextFildData}";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       focusNode: _focusNode,
//       controller: widget.controller,
//       keyboardType: widget.inputType,
//       obscureText:
//           widget.title == "Password" && !_isPasswordVisible ? true : false,
//       cursorColor: AppVar.secondary, // Change cursor color
//       style: TextStyle(
//         color: AppVar.seconndTextColor, // Change text color
//         fontSize: AppVar.littelFontSize, // Change text font size
//       ),
//       decoration: InputDecoration(
//         isDense: true,
//         prefixIcon: widget.prefixIcon,
//         //  widget.title == "Password"
//         //     ? const Icon(Icons.lock)
//         //     :widget.title == "Email"? const Icon(Icons.email):null,
//         suffixIcon: widget.title == "Password"
//             ? GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _isPasswordVisible = !_isPasswordVisible;
//                   });
//                 },
//                 child: Icon(
//                   _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                   color: AppVar.primarySoft,
//                 ),
//               )
//             : null,
//         fillColor: _isFocused ? Colors.transparent : Colors.transparent,
//         filled: true,
//         hintText: widget.hintText,
//         hintStyle: const TextStyle(
//             color: Color.fromARGB(197, 255, 255, 255), fontSize: 14),

//         // Customize the border color and radius
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//               color: AppVar.secondarySoft, width: 2.0), // Bottom border
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide:
//               BorderSide(color: AppVar.secondary, width: 2.0), // Bottom border
//         ),
//         // Customize error design
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(color: Colors.red, width: 2.0),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
//         ),
//         errorStyle: const TextStyle(
//           color: Colors.redAccent,
//           fontWeight: FontWeight.bold,
//         ),
//         // Adjust the height of the TextField using contentPadding
//         contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
//       ),
//       validator: widget.validator,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';

class CustomeLoginTextFormField extends StatefulWidget {
  const CustomeLoginTextFormField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.title,
    required this.controller,
    required this.validator,
    this.prefixIcon,
    this.isFilledTextFild,
    this.filledTextFildData,
  }) : super(key: key);

  final String hintText;
  final String title;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool? isFilledTextFild;
  final String? filledTextFildData;

  @override
  State<CustomeLoginTextFormField> createState() =>
      _CustomeLoginTextFormFieldState();
}

class _CustomeLoginTextFormFieldState extends State<CustomeLoginTextFormField> {
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
    if (widget.isFilledTextFild != null) {
      widget.controller.text = "${widget.filledTextFildData}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = screenWidth > screenHeight;
    final isTablet = screenWidth > 600;
    final textFieldFontSize = screenWidth *
        (isLandscape
            ? 0.03
            : isTablet
                ? 0.02
                : 0.04); // Smaller font size in landscape
    final contentPaddingVertical = screenWidth *
        (isLandscape ? 0.025 : 0.03); // Adjust padding for landscape

    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText:
          widget.title == "Password" && !_isPasswordVisible ? true : false,
      cursorColor: AppVar.secondary, // Change cursor color
      style: TextStyle(
        color: AppVar.seconndTextColor, // Change text color
        fontSize: textFieldFontSize, // Responsive text font size
      ),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.title == "Password"
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                child: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: AppVar.primarySoft,
                  size: textFieldFontSize,
                ),
              )
            : null,
        fillColor: _isFocused ? Colors.transparent : Colors.transparent,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: const Color.fromARGB(197, 255, 255, 255),
            fontSize: textFieldFontSize * 0.9), // Slightly smaller hint text
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AppVar.secondarySoft, width: 2.0), // Bottom border
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: AppVar.secondary, width: 2.0), // Bottom border
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: contentPaddingVertical, // Dynamic content padding
        ),
      ),
      validator: widget.validator,
    );
  }
}
