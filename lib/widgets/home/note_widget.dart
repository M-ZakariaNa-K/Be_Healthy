import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    final isTaplet = MediaQuery.of(context).size.width > 800;
    final dataFontSize = screenWidth *
        (isTaplet ? 0.03 : 0.07); // Smaller font size in landscape
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTaplet ? dataFontSize : 16,
              color: AppVar.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            // width: MediaQuery.sizeOf(context).width - 100,
            child: Text(
              content,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isTaplet ? dataFontSize : 16,
                color: AppVar.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
