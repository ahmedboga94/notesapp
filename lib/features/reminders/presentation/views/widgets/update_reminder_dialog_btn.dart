import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/utils/custom_show_dialog.dart';
import '../../../domain/entities/reminder_entity.dart';
import '../../cubit/reminders/reminders_cubit.dart';
import 'reminder_color_items_list_view.dart';

class UpdateReminderDialogBtn extends StatefulWidget {
  final ReminderEntity reminderEntity;
  const UpdateReminderDialogBtn({super.key, required this.reminderEntity});

  @override
  State<UpdateReminderDialogBtn> createState() =>
      _UpdateReminderDialogBtnState();
}

class _UpdateReminderDialogBtnState extends State<UpdateReminderDialogBtn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController subTitleCtrl = TextEditingController();

  @override
  void initState() {
    titleCtrl.text = widget.reminderEntity.title;
    subTitleCtrl.text = widget.reminderEntity.subTitle;

    super.initState();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    subTitleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        customShowDialog(
            context: context,
            isConfirm: false,
            title: "Update Reminder",
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleCtrl,
                    decoration: InputDecoration(hintText: context.titleKey),
                    validator: (value) =>
                        value!.isEmpty ? context.enterTitleNoteKey : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: subTitleCtrl,
                    decoration: InputDecoration(hintText: context.contantKey),
                    validator: (value) =>
                        value!.isEmpty ? context.enterContentNoteKey : null,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  ReminderColorItemsListView(
                      reminderEntity: widget.reminderEntity, isUpdate: true),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.reminderEntity.title = titleCtrl.text;
                            widget.reminderEntity.subTitle = subTitleCtrl.text;

                            BlocProvider.of<RemindersCubit>(context)
                                .updateReminder(widget.reminderEntity);
                            GoRouter.of(context).pop();
                          }
                        },
                        child: Text(context.updateKey)),
                  ),
                ],
              ),
            ));
      },
      icon: const Icon(
        Ionicons.pencil,
        size: 30,
        color: AppColors.darkColor,
      ),
    );
  }
}
