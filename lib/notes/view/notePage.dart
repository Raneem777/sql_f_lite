import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/bases/baseAppBar.dart';
import 'package:sql_f_lite/bases/baseScaffold.dart';
import 'package:sql_f_lite/notes/view/myHomePage.dart';
import 'package:sql_f_lite/notes/viewModel/viewModel.dart';

import 'package:sql_f_lite/constants/colors.dart';
import 'package:sql_f_lite/notes/repositry/model/data.dart';
import 'package:sql_f_lite/reuseablaComponents/showDeleteDialoge.dart';

class NoteDetailPage extends ConsumerStatefulWidget {
  final int userId;

  const NoteDetailPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends ConsumerState<NoteDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    // Fetch user details and initialize controllers
    final user =
        ref.read(notesViewModelProvider.notifier).getUserById(widget.userId);
    _titleController = TextEditingController(text: user?.title);
    _noteController = TextEditingController(text: user?.note);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: appBarBase(
            context,
            "Your Note",
            IconButton(
                onPressed: () {
                  showDeleteConfirmationDialog(context, ref, widget.userId);
                },
                icon: Icon(
                  Icons.delete,
                  color: red,
                ))),
        viewModel: notesViewModelProvider,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: purple),
                    ),
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _noteController,
                    maxLines: null, // Allow multiple lines
                    decoration: InputDecoration(
                      labelText: 'Note',
                      labelStyle: TextStyle(color: purple),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleLite,
          heroTag: 'edit',
          onPressed: () {
            final updatedUser = User(
              id: widget.userId,
              title: _titleController.text,
              note: _noteController.text,
            );
            ref.read(notesViewModelProvider.notifier).updateUser(updatedUser);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Myhomepage()));
          },
          child: Icon(
            Icons.save,
            color: white,
          ),
        ));
  }
}
