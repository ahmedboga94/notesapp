import 'package:flutter/material.dart';
import 'package:notesapp/core/app_colors.dart';

class ReminderColorItem extends StatelessWidget {
  final bool isSelected;
  final Color color;
  final Function() onTap;
  const ReminderColorItem(
      {super.key,
      required this.isSelected,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
          radius: 30,
          backgroundColor: isSelected ? AppColors.lessdarkColor : color,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: color,
          )),
    );
  }
}
