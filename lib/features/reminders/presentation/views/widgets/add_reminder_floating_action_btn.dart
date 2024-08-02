import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';
import 'package:notesapp/features/reminders/domain/entities/reminder_entity.dart';
import 'package:notesapp/features/reminders/presentation/cubit/reminders/reminders_cubit.dart';

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

  DateTime dateTime = DateTime.now();
  DateTime? dateTimeSelected;

  Future<DateTime?> pickDate() {
    return showDatePicker(
        context: context,
        initialDate: dateTimeSelected ?? dateTime,
        firstDate: dateTime,
        lastDate: DateTime(2100));
  }

  Future<TimeOfDay?> pickTime() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
            dateTime.copyWith(minute: dateTime.minute + 1)));
  }

  Future picDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final newDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    dateTimeSelected = newDate;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: titleCtrl,
                            decoration: InputDecoration(
                                hintText: context.titleReminderKey),
                            validator: (value) => value!.isEmpty
                                ? context.enterTitleReminderKey
                                : null,
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: subTitleCtrl,
                            decoration: InputDecoration(
                                hintText: context.contentReminderKey),
                            validator: (value) => value!.isEmpty
                                ? context.enterContentNoteKey
                                : null,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 15),
                          ReminderColorItemsListView(
                              reminderEntity: widget.reminderEntity),
                          const SizedBox(height: 15),
                          ElevatedButton(
                              onPressed: () async {
                                await picDateTime();
                                setState(() {});
                              },
                              child: Text(
                                dateTimeSelected == null
                                    ? context.noSelectedDateTimeKey
                                    : DateFormat("yyyy-MM-dd hh:mm a")
                                        .format(dateTimeSelected!),
                              )),
                          const SizedBox(height: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (dateTimeSelected!
                                          .isAfter(DateTime.now())) {
                                        final ReminderEntity addReminder =
                                            ReminderEntity(
                                                title: titleCtrl.text,
                                                subTitle: subTitleCtrl.text,
                                                dateTime: dateTimeSelected!,
                                                color: Colors.yellow.value,
                                                isNotificationEnabled: true);

                                        BlocProvider.of<RemindersCubit>(context)
                                            .addReminder(addReminder);
                                        GoRouter.of(context).pop();
                                        dateTimeSelected = null;
                                        titleCtrl.clear();
                                        subTitleCtrl.clear();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                duration:
                                                    const Duration(seconds: 2),
                                                content: Text(
                                                    context.addReminderKey)));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(context
                                                    .enterCorrectDateTimeKey)));
                                      }
                                    }
                                  },
                                  child: Text(context.addKey))),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: const Icon(Ionicons.add),
    );
  }
}
