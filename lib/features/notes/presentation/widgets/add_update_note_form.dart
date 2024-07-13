import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/core/app_translate_keys.dart';

import '../../../../core/enums/add_edit_note_enum.dart';
import '../../domain/entities/note_entity.dart';
import '../cubit/notes/notes_cubit.dart';
import 'notes_color_items_list_view.dart';

class AddUpdateNoteForm extends StatefulWidget {
  final AddUpdateNoteEnum addEditNoteEnum;
  final NoteEntity? noteEntity;

  const AddUpdateNoteForm(
      {super.key, required this.addEditNoteEnum, this.noteEntity});

  @override
  State<AddUpdateNoteForm> createState() => _AddUpdateNoteFormState();
}

class _AddUpdateNoteFormState extends State<AddUpdateNoteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController subTitleCtrl = TextEditingController();

  @override
  void initState() {
    if (widget.addEditNoteEnum == AddUpdateNoteEnum.editNoteView) {
      titleCtrl.text = widget.noteEntity!.title;
      subTitleCtrl.text = widget.noteEntity!.subTitle;
    }
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
    return Form(
      key: _formKey,
      child: Column(
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
            maxLines: 7,
          ),
          const SizedBox(height: 20),
          NotesColorItemsListView(
              addEditNoteEnum: widget.addEditNoteEnum,
              noteEntity: widget.noteEntity),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.06,
            child: widget.addEditNoteEnum == AddUpdateNoteEnum.addNoteView
                ? ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final randomId = DateTime.now().millisecondsSinceEpoch;
                        DateTime dateTime =
                            DateTime.fromMillisecondsSinceEpoch(randomId);
                        String formattedDate =
                            DateFormat("MMMM dd, yy").format(dateTime);

                        final NoteEntity addNote = NoteEntity(
                            title: titleCtrl.text,
                            subTitle: subTitleCtrl.text,
                            dateTime: formattedDate,
                            color: Colors.yellow.value);

                        BlocProvider.of<NotesCubit>(context).addNote(addNote);
                      }
                    },
                    child: Text(context.addKey))
                : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.noteEntity!.title = titleCtrl.text;
                        widget.noteEntity!.subTitle = subTitleCtrl.text;

                        BlocProvider.of<NotesCubit>(context)
                            .updateNote(widget.noteEntity!);
                      }
                    },
                    child: Text(context.updateKey)),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
