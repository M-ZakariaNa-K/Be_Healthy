import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/auth/view/login_screen_MobileLayout.dart';
import 'package:tracking_system_app/modules/auth/view/login_screen_tablet_layout.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final horizontalPadding = mediaQueryData.size.width;

    return LayoutBuilder(builder: (context, constraints) {
      if (horizontalPadding <= 850) {
        return LoginScreenMobileLayout(context);
      } else {
        return LoginScreenTapletLayout(context);
        // return TabletLayoutLoginScreen(context);
      }
    });
  }
}
