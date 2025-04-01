import 'package:flutter/material.dart';
import '../utils/constants/app_colors.dart';

class TabOptionsWidget extends StatelessWidget {
  final List<String> tabNames;
  final int selectedIndex;
  final Function(int) onTabSelected;
  final double containerHeight;
  final double buttonHeight;
  final double buttonGap;
  final Color selectedColor;

  const TabOptionsWidget({
    Key? key,
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabSelected,
    this.containerHeight = 76.0,
    this.buttonHeight = 44.0,
    this.buttonGap = 8.0,
    this.selectedColor = const Color(0xFF695CFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: containerHeight,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: List.generate(
          tabNames.length,
          (index) {
            final bool isSelected = index == selectedIndex;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: buttonGap / 2),
                child: _buildTab(context, index, tabNames[index], isSelected),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTab(
      BuildContext context, int index, String label, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTabSelected(index),
        borderRadius: BorderRadius.circular(40),
        splashColor: selectedColor.withOpacity(0.3),
        highlightColor: selectedColor.withOpacity(0.1),
        child: Ink(
          height: buttonHeight,
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : AppColors.white,
            borderRadius: BorderRadius.circular(40),
            border: isSelected
                ? null
                : Border.all(
                    color: AppColors.border,
                    width: 0.5,
                  ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }
}
