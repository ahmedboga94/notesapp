import 'package:flutter/material.dart';
import 'package:notesapp/core/app_colors.dart';

class ColorItem extends StatelessWidget {
  final bool isSelected;
  final Color color;
  const ColorItem({super.key, required this.isSelected, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 30,
        backgroundColor: isSelected ? AppColors.lightGreyColor : color,
        child: CircleAvatar(
          radius: 26,
          backgroundColor: color,
        ));
  }
}
