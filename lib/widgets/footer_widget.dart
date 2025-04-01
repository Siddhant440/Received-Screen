import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final Widget leftContent;
  final Widget rightContent;
  final Color backgroundColor;
  final double height;
  final EdgeInsetsGeometry padding;
  final List<BoxShadow>? boxShadow;

  const FooterWidget({
    Key? key,
    required this.leftContent,
    required this.rightContent,
    this.backgroundColor = Colors.white,
    this.height = 72.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 19.0),
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: boxShadow ??
            [
              const BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
      ),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftContent,
            rightContent,
          ],
        ),
      ),
    );
  }
}

class ItemsFooterWidget extends StatelessWidget {
  final int itemCount;
  final VoidCallback onContinue;

  const ItemsFooterWidget({
    Key? key,
    required this.itemCount,
    required this.onContinue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Items added text only
          Text(
            '$itemCount items added',
            style: const TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF414651),
            ),
          ),

          // Continue button
          TextButton(
            onPressed: onContinue,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              backgroundColor: Colors.transparent,
            ),
            child: Row(
              children: [
                const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF695CFF),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFF695CFF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
