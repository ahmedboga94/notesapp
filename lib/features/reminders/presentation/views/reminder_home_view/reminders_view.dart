import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/reminders/reminders_cubit.dart';
import '../widgets/add_reminder_floating_action_btn.dart';
import '../widgets/custom_reminder_app_bar.dart';
import '../widgets/reminders_body.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersCubit, RemindersState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: const CustomRemindersAppBar()),
          floatingActionButton: Visibility(
            visible: !context.read<RemindersCubit>().isMultiSelectionEnabled,
            child: const AddReminderFloatingActionBtn(),
          ),
          body: const RemindersBody(),
        );
      },
    );
  }
}
