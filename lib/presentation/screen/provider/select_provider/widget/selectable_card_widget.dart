import 'package:flutter/material.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';

class SelectableCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Color primaryColor;

  const SelectableCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height:Dimensions.h(55),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: primaryColor,
            width: 1.2,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
