import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/constants/colors.dart';
import 'package:sql_f_lite/constants/textControllers.dart';
import 'package:sql_f_lite/constants/texts.dart';
import 'package:sql_f_lite/notes/repositry/model/data.dart';
import 'package:sql_f_lite/notes/view/myHomePage.dart';
import 'package:sql_f_lite/notes/viewModel/viewModel.dart';

Future<void> showAddNoteDialog(BuildContext context, WidgetRef ref) async {
  final _formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: purple,
        title: addNote,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 1,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration:
                        InputDecoration(labelText: 'title', fillColor: white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: noteController,
                    decoration:
                        InputDecoration(labelText: 'note', fillColor: white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a note';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, proceed with adding the user
                String title = titleController.text;
                String note = noteController.text;

                // print("Title: $title, Note: $note");
                // Add the user
                User user = User(title: title, note: note);
                ref
                    .read(notesViewModelProvider.notifier)
                    .addUser(user)
                    .then((value) {
                  if (value == 200) {
                    Navigator.pop(context);
                    ref.read(notesViewModelProvider.notifier).fetchNotes();
                  }
                });
                print("Title: $title, Note: $note");

                // Clear the fields and close the dialog
                titleController.clear();
                noteController.clear();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Myhomepage()));
              }
            },
          ),
        ],
      );
    },
  );
}
