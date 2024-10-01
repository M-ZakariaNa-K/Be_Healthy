import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: Lottie.asset(
          fit: BoxFit.fill,
          'assets/Lottie/MainLoadingIndecetor.json', // Path to your Lottie animation file
        ),
      ),
    );
  }
}
