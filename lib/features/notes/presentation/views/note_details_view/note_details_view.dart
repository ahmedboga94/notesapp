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
    // DateTime dateTime =
    //     DateTime.fromMillisecondsSinceEpoch(widget.noteEntity.id.toInt());
    // String formattedDate = DateFormat("MMMM dd, yy").format(dateTime);
    // String formattedTime = DateFormat("hh:mma").format(dateTime);

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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
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
      // bottomNavigationBar: SizedBox(
      //   height: MediaQuery.of(context).size.height * 0.1,
      //   child: Center(
      //     child: ElevatedButton(
      //         onPressed: () => GoRouter.of(context)
      //             .push(AppRoutes.noteEditView, extra: noteEntity),
      //         child: const Text("Update")),
      //   ),
      // ),
    );
  }
}
