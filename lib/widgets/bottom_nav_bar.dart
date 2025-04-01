import 'package:flutter/material.dart';
import '../utils/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final double height;
  final List<BottomNavItem> items;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.height = 79.0,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.navbarLightBackground,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) => _buildNavItem(context, index),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final bool isSelected = index == selectedIndex;
    final BottomNavItem item = items[index];

    return Expanded(
      child: InkWell(
        onTap: () => onItemTapped(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item.iconPath,
              width: item.iconSize,
              height: item.iconSize,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.primary : AppColors.navIconGrey,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: item.iconTextGap),
            Container(
              height: 18, // Fixed height for text container
              alignment: Alignment.center,
              child: Text(
                item.label,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.navIconGrey,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem {
  final String label;
  final String iconPath;
  final double iconSize;
  final double iconTextGap;

  const BottomNavItem({
    required this.label,
    required this.iconPath,
    required this.iconSize,
    this.iconTextGap = 6.0,
  });
}
