import 'package:flutter/material.dart';
import '../utils/constants/app_colors.dart';

class StatusButtonsWidget extends StatelessWidget {
  final double statusButtonHeight;
  final double? statusButtonWidth;
  final double statusButtonGap;
  final Color selectedColor;
  final double iconTextGap;
  final double iconWidth;
  final double iconHeight;

  const StatusButtonsWidget({
    Key? key,
    this.statusButtonHeight = 40.0,
    this.statusButtonWidth,
    this.statusButtonGap = 14.0,
    this.selectedColor = const Color(0xFF695CFF),
    this.iconTextGap = 3.0,
    this.iconWidth = 14.0,
    this.iconHeight = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Row(
        children: [
          // Pending Button (Selected)
          statusButtonWidth != null
              ? SizedBox(
                  width: statusButtonWidth,
                  child: _buildStatusButton(
                    label: 'Pending',
                    isSelected: true,
                    icon: Icons.schedule_outlined,
                  ),
                )
              : Expanded(
                  child: _buildStatusButton(
                    label: 'Pending',
                    isSelected: true,
                    icon: Icons.schedule_outlined,
                  ),
                ),
          SizedBox(width: statusButtonGap),
          // Approved Button (Not Selected)
          statusButtonWidth != null
              ? SizedBox(
                  width: statusButtonWidth,
                  child: _buildStatusButton(
                    label: 'Approved',
                    isSelected: false,
                    icon: Icons.check_circle_outline,
                  ),
                )
              : Expanded(
                  child: _buildStatusButton(
                    label: 'Approved',
                    isSelected: false,
                    icon: Icons.check_circle_outline,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildStatusButton({
    required String label,
    required bool isSelected,
    required IconData icon,
  }) {
    return Container(
      height: statusButtonHeight,
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: isSelected
            ? null
            : Border.all(
                color: selectedColor,
                width: 0.5,
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : selectedColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: iconTextGap),
          Icon(
            icon,
            size: iconWidth,
            color: isSelected ? Colors.white : selectedColor,
          ),
        ],
      ),
    );
  }
}
