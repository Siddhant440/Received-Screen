import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isRequired;
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomDropdown({
    super.key,
    required this.label,
    this.hintText = '',
    this.isRequired = false,
    required this.options,
    this.selectedValue,
    required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '$label*' : label,
          style: const TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.14,
            color: Colors.black,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFABAFB1),
              width: 0.5,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedValue,
                hint: Row(
                  children: [
                    if (prefixIcon != null) ...[
                      prefixIcon!,
                      const SizedBox(width: 12),
                    ],
                    Text(
                      hintText,
                      style: const TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 12,
                        color: Color(0xFFABAFB1),
                      ),
                    ),
                  ],
                ),
                icon: suffixIcon ??
                    const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFFABAFB1)),
                items: options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
