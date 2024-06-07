import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/add_edit_note_enum.dart';
import '../../domain/entities/note_entity.dart';
import '../cubit/notes/notes_cubit.dart';
import 'color_items_list_view.dart';

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

  String title = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue:
                widget.addEditNoteEnum == AddUpdateNoteEnum.addNoteView
                    ? ""
                    : title = widget.noteEntity!.title,
            decoration: const InputDecoration(hintText: "Title"),
            validator: (value) => value!.isEmpty ? "Please Enter Title" : null,
            onChanged: (value) => title = value,
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue:
                widget.addEditNoteEnum == AddUpdateNoteEnum.addNoteView
                    ? ""
                    : content = widget.noteEntity!.subTitle,
            decoration: const InputDecoration(hintText: "Content"),
            validator: (value) =>
                value!.isEmpty ? "Please Enter Content" : null,
            onChanged: (value) => content = value,
            maxLines: 7,
          ),
          const SizedBox(height: 20),
          ColorItemsListView(
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
                            title: title,
                            subTitle: content,
                            dateTime: formattedDate,
                            color: Colors.yellow.value);

                        BlocProvider.of<NotesCubit>(context).addNote(addNote);
                      }
                    },
                    child: const Text("Add"))
                : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.noteEntity!.title = title;
                        widget.noteEntity!.subTitle = content;

                        BlocProvider.of<NotesCubit>(context)
                            .updateNote(widget.noteEntity!);
                      }
                    },
                    child: const Text("Update")),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
