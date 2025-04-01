import 'package:flutter/material.dart';

class RoundAddButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double fontSize;
  final double borderRadius;
  final double iconSize;
  final double height;
  final BorderSide borderSide;

  const RoundAddButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.textColor = const Color(0xFF455A64),
    this.iconColor = const Color(0xFF455A64),
    this.fontSize = 10,
    this.borderRadius = 73,
    this.iconSize = 12,
    this.height = 24,
    this.borderSide = const BorderSide(
      color: Color(0xFFABAFB1),
      width: 0.5,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.fromBorderSide(borderSide),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.add,
                size: iconSize,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
