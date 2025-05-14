import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';

class TopOptionsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const TopOptionsButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        overlayColor: Colors.white,
        backgroundColor: AppConstants.textButtonColors[text],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppConstants.textIconButton[text] ?? "",
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: AppConstants.textButtonIconColors[text] ?? Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
