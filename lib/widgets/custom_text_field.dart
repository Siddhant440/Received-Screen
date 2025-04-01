import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isRequired;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final double height;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hintText = '',
    this.isRequired = false,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.height = 44.0,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.14,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: const TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.14,
                    color: Color(0xFFD22121),
                    height: 1.2,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: maxLines! > 1 ? null : height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFABAFB1),
              width: 0.5,
            ),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.12,
                color: Color(0xFFABAFB1),
                height: 1.2,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              border: InputBorder.none,
            ),
            maxLines: maxLines,
            style: const TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.12,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
