import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/enums/add_edit_note_enum.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';

import '../../../../core/app_colors.dart';
import '../cubit/notes/notes_cubit.dart';
import 'color_item.dart';

class ColorItemsListView extends StatefulWidget {
  final AddUpdateNoteEnum addEditNoteEnum;
  final NoteEntity? noteEntity;
  const ColorItemsListView(
      {super.key, required this.addEditNoteEnum, this.noteEntity});

  @override
  State<ColorItemsListView> createState() => _ColorItemsListViewState();
}

class _ColorItemsListViewState extends State<ColorItemsListView> {
  int currentIndex = 0;

  seletedColorMethod() {
    if (widget.addEditNoteEnum == AddUpdateNoteEnum.editNoteView) {
      Color selectedColor = Color(widget.noteEntity!.color);
      for (int i = 0; i < AppColors.colorsList.length; i++) {
        if (AppColors.colorsList[i] == selectedColor) {
          currentIndex = i;
          BlocProvider.of<NotesCubit>(context).changeColor(selectedColor);
          break;
        }
      }
    } else {
      BlocProvider.of<NotesCubit>(context)
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
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return SizedBox(
          height: 28 * 2,
          child: ListView.separated(
            itemCount: AppColors.colorsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Builder(builder: (context) {
                final color = AppColors.colorsList[index];
                return GestureDetector(
                    onTap: () {
                      context.read<NotesCubit>().changeColor(color);

                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: ColorItem(
                        color: color, isSelected: currentIndex == index));
              });
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        );
      },
    );
  }
}
