import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';

import '../../../../../../core/utils/custom_show_dialog.dart';
import '../../../../../notes/presentation/widgets/notes_color_items_list_view.dart';
import 'reminder_color_items_list_view.dart';

class AddReminderFloatingActionBtn extends StatefulWidget {
  final ReminderEntity? reminderEntity;
  const AddReminderFloatingActionBtn({super.key, this.reminderEntity});

  @override
  State<AddReminderFloatingActionBtn> createState() =>
      _AddReminderFloatingActionBtnState();
}

class _AddReminderFloatingActionBtnState
    extends State<AddReminderFloatingActionBtn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController subTitleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        customShowDialog(
            context: context,
            isConfirm: false,
            title: "Add Reminder",
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
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  // ReminderColorItemsListView(
                  //     reminderEntity: widget.reminderEntity),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final randomId =
                                  DateTime.now().millisecondsSinceEpoch;
                              DateTime dateTime =
                                  DateTime.fromMillisecondsSinceEpoch(randomId);
                              String formattedDate =
                                  DateFormat("MMMM dd, yy").format(dateTime);

                              final ReminderEntity addReminder = ReminderEntity(
                                  title: titleCtrl.text,
                                  subTitle: subTitleCtrl.text,
                                  dateTime: formattedDate,
                                  color: Colors.yellow.value);

                              BlocProvider.of<RemindersCubit>(context)
                                  .addReminder(addReminder);
                              GoRouter.of(context).pop();
                            }
                          },
                          child: Text(context.addKey))),
                ],
              ),
            ));
      },
      child: const Icon(Ionicons.add),
    );
  }
}
