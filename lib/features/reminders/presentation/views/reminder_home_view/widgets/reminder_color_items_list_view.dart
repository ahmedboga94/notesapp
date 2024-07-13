import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../notes/presentation/widgets/color_item.dart';

class ReminderColorItemsListView extends StatefulWidget {
  final ReminderEntity? reminderEntity;
  final bool isUpdate;
  const ReminderColorItemsListView({
    super.key,
    this.reminderEntity,
    this.isUpdate = false,
  });

  @override
  State<ReminderColorItemsListView> createState() =>
      _ReminderColorItemsListViewState();
}

class _ReminderColorItemsListViewState
    extends State<ReminderColorItemsListView> {
  int currentIndex = 0;

  seletedColorMethod() {
    if (widget.isUpdate) {
      Color selectedColor = Color(widget.reminderEntity!.color);
      for (int i = 0; i < AppColors.colorsList.length; i++) {
        if (AppColors.colorsList[i] == selectedColor) {
          currentIndex = i;
          BlocProvider.of<RemindersCubit>(context).changeColor(selectedColor);
          break;
        }
      }
    } else {
      BlocProvider.of<RemindersCubit>(context)
          .changeColor(AppColors.colorsList[currentIndex]);
    }
  }

  @override
  void initState() {
    seletedColorMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersCubit, RemindersState>(
      builder: (context, state) {
        return SizedBox(
          height: 28 * 2,
          child: ListView.separated(
            itemCount: AppColors.colorsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Builder(builder: (context) {
                final color = AppColors.colorsList[index];
                return ColorItem(
                    onTap: () {
                      context.read<RemindersCubit>().changeColor(color);
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    color: color,
                    isSelected: currentIndex == index);
              });
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        );
      },
    );
  }
}
