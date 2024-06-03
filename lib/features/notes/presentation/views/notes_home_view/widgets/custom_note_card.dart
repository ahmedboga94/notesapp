import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_routes.dart';
import '../../../../domain/entities/note_entity.dart';
import '../../../cubit/notes/notes_cubit.dart';

class CustomNoteCard extends StatelessWidget {
  final NoteEntity noteEntity;

  const CustomNoteCard({super.key, required this.noteEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      color: Color(noteEntity.color),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
                title: Text(noteEntity.title,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: AppColors.darkColor)),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Opacity(
                      opacity: 0.5,
                      child: Text(noteEntity.subTitle,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.darkColor))),
                ),
                trailing: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () =>
                        context.read<NotesCubit>().deleteNote(noteEntity),
                    icon: const Icon(Ionicons.close_circle,
                        size: 28, color: AppColors.darkColor)),
                onTap: () => GoRouter.of(context)
                    .push(AppRoutes.noteDetailsView, extra: noteEntity)),
            Opacity(
              opacity: 0.7,
              child: Text(noteEntity.dateTime,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.darkColor)),
            ),
          ],
        ),
      ),
    );
  }
}
