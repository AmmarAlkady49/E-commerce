import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ModernGenderSelector extends StatelessWidget {
  final String? selectedGender;
  final Function(String) onGenderSelected;

  const ModernGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 57.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildGenderOption(
              context: context,
              value: 'male',
              label: S.of(context).male,
              icon: Iconsax.man,
              activeColor: Colors.blueAccent,
            ),
          ),
          Container(
            height: 25.h,
            width: 1,
            color: Colors.grey.withAlpha(80),
          ),
          Expanded(
            child: _buildGenderOption(
              context: context,
              value: 'female',
              label: S.of(context).female,
              icon: Iconsax.woman,
              activeColor: Colors.pinkAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption({
    required BuildContext context,
    required String value,
    required String label,
    required IconData icon,
    required Color activeColor,
  }) {
    final bool isSelected = selectedGender == value;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onGenderSelected(value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color:
                    isSelected ? activeColor.withAlpha(60) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: isSelected ? activeColor : Colors.grey,
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: FontHelper.fontText(
                    context: context,
                    size: isSelected ? 15.sp : 13.sp,
                    weight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? activeColor : Colors.grey.shade600,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 25.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: isSelected ? activeColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
