import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../../core/app_colors.dart';
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
  void initState() {
    titleCtrl.text = widget.reminderEntity.title;
    subTitleCtrl.text = widget.reminderEntity.subTitle;
    dateTimeSelected = widget.reminderEntity.dateTime;

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
                          validator: (value) =>
                              value!.isEmpty ? context.enterTitleNoteKey : null,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: subTitleCtrl,
                          decoration: InputDecoration(
                              hintText: context.contentReminderKey),
                          validator: (value) => value!.isEmpty
                              ? context.enterContentReminderKey
                              : null,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 15),
                        ReminderColorItemsListView(
                            reminderEntity: widget.reminderEntity,
                            isUpdate: true),
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
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  widget.reminderEntity.title = titleCtrl.text;
                                  widget.reminderEntity.subTitle =
                                      subTitleCtrl.text;
                                  widget.reminderEntity.dateTime =
                                      dateTimeSelected!;

                                  BlocProvider.of<RemindersCubit>(context)
                                      .updateReminder(widget.reminderEntity);
                                  GoRouter.of(context).pop();
                                }
                              },
                              child: Text(context.updateKey)),
                        ),
                      ],
                    ),
                  ),
                ));
              },
            );
          },
        );
      },
      icon: const Icon(
        Ionicons.pencil,
        size: 30,
        color: AppColors.darkColor,
      ),
    );
  }
}
