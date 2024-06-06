import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_routes.dart';
import '../../../domain/entities/note_entity.dart';

class NoteDetailsView extends StatelessWidget {
  final NoteEntity noteEntity;
  const NoteDetailsView({super.key, required this.noteEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Note View")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context)
            .push(AppRoutes.noteEditView, extra: noteEntity),
        child: const Icon(Ionicons.pencil),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(right: 14, left: 14, top: 14, bottom: 40),
        child: Center(
          child: Card(
            color: Color(noteEntity.color),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  children: [
                    Text(noteEntity.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: AppColors.darkColor)),
                    Opacity(
                      opacity: 0.7,
                      child: Text(noteEntity.dateTime,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColors.darkColor)),
                    ),
                    const Divider(color: AppColors.lessdarkColor),
                    Text(noteEntity.subTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.darkColor)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
