import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/auth/view/forget_password_screen_mobile_layout.dart';
import 'package:tracking_system_app/modules/auth/view/forget_password_screen_tablet_layout.dart';

// ignore: must_be_immutable
class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final horizontalPadding = mediaQueryData.size.width;

    return LayoutBuilder(builder: (context, constraints) {
      if (horizontalPadding <= 850) {
        return ForgetPasswordScreenMobileLayout(context);
      } else {
        return ForgetPasswordScreenTapletLayout(context);
        // return TabletLayoutLoginScreen(context);
      }
    });
  }
}
