import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CartButton extends StatelessWidget {
  final String text;
  final String? svgAsset;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool hasBorder;
  final bool isLight;
  final double width;
  final double height;

  const CartButton({
    Key? key,
    required this.text,
    this.svgAsset,
    required this.onPressed,
    this.isPrimary = false,
    this.hasBorder = true,
    this.isLight = false,
    this.width = 83,
    this.height = 26,
  }) : super(key: key);

  /// Factory constructor for creating an Edit button
  factory CartButton.edit({
    Key? key,
    required VoidCallback onPressed,
    double width = 83,
    double height = 26,
  }) {
    return CartButton(
      key: key,
      text: 'Edit',
      svgAsset: 'assets/svgs/edit_icon.svg',
      onPressed: onPressed,
      isPrimary: false,
      hasBorder: true,
      width: width,
      height: height,
    );
  }

  /// Factory constructor for creating an Add button
  factory CartButton.add({
    Key? key,
    required VoidCallback onPressed,
    double width = 83,
    double height = 26,
  }) {
    return CartButton(
      key: key,
      text: 'Add',
      svgAsset: 'assets/svgs/add_cart_icon.svg',
      onPressed: onPressed,
      isPrimary: true,
      width: width,
      height: height,
    );
  }

  /// Factory constructor for creating a light button (F2F0FC background, no border)
  factory CartButton.light({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    String? svgAsset,
    double? width,
    double height = 44,
  }) {
    return CartButton(
      key: key,
      text: text,
      svgAsset: svgAsset,
      onPressed: onPressed,
      isPrimary: false,
      hasBorder: false,
      isLight: true,
      width: width ?? double.infinity,
      height: height,
    );
  }

  /// Factory constructor for creating a primary solid button without icon
  factory CartButton.primary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    double? width,
    double height = 44,
  }) {
    return CartButton(
      key: key,
      text: text,
      svgAsset: null,
      onPressed: onPressed,
      isPrimary: true,
      hasBorder: false,
      width: width ?? double.infinity,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define colors based on button type
    Color backgroundColor;
    Color textColor;

    if (isLight) {
      backgroundColor = const Color(0xFFF2F0FC);
      textColor = const Color(0xFF695CFF);
    } else if (isPrimary) {
      backgroundColor = AppColors.primary;
      textColor = Colors.white;
    } else {
      backgroundColor = Colors.white;
      textColor = AppColors.primary;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: hasBorder && !isLight
                ? BorderSide(
                    color: AppColors.primary,
                    width: 0.5,
                  )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyles.s12w500.copyWith(color: textColor),
            ),
            if (svgAsset != null) ...[
              const SizedBox(width: 4),
              SvgPicture.asset(
                svgAsset!,
                width: isPrimary ? 14 : 8,
                height: isPrimary ? 14 : 8,
                color: textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
