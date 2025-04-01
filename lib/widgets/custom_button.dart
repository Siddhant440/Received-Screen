import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isEnabled;
  final bool squareCorners;
  final double? width;
  final double height;
  final IconData? icon;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.isEnabled = true,
    this.squareCorners = false,
    this.width,
    this.height = 44.0,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine colors based on state
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    if (!isEnabled) {
      // Disabled state
      backgroundColor = const Color(0xFFEFEFEF);
      textColor = const Color(0xFF707070);
      borderColor = const Color(0xFFEFEFEF);
    } else if (isPrimary) {
      // Primary enabled state
      backgroundColor = const Color(0xFF695CFF);
      textColor = Colors.white;
      borderColor = const Color(0xFF695CFF);
    } else {
      // Secondary enabled state
      backgroundColor = const Color(0xFFF2F0FC);
      textColor = const Color(0xFF695CFF);
      borderColor = const Color(0xFF695CFF);
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius:
                squareCorners ? BorderRadius.zero : BorderRadius.circular(8),
            side: isEnabled && (isPrimary || !isPrimary)
                ? BorderSide(color: borderColor, width: 1)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(
                icon,
                size: 16,
                color: textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
