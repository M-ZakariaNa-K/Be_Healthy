import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/auth/view/regester_screen_mobile_layout.dart';
import 'package:tracking_system_app/modules/auth/view/regester_screen_tablet_layout.dart';

// ignore: must_be_immutable
class RegesterView extends StatelessWidget {
  const RegesterView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final horizontalPadding = mediaQueryData.size.width;

    return LayoutBuilder(builder: (context, constraints) {
      if (horizontalPadding <= 850) {
        return RegesterScreenMobileLayout(context);
      } else {
        return RegesterScreenTapletLayout(context);
      }
    });
  }
}
