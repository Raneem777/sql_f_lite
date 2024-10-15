import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/bases/baseAppBar.dart';
import 'package:sql_f_lite/bases/showDeleteDialoge.dart';
import 'package:sql_f_lite/constants/colors.dart';
import 'package:sql_f_lite/model/data.dart';
import 'package:sql_f_lite/viewModel/userProvider.dart';

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
        ref.read(userViewModelProvider.notifier).getUserById(widget.userId);
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
    return Scaffold(
      backgroundColor: black,
      appBar: appBarBase(context, "Your Note"),
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
                    color: white,
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
                    color: white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: purpleLite,
            heroTag: 'edit',
            onPressed: () {
             
              final updatedUser = User(
                id: widget.userId,
                title: _titleController.text,
                note: _noteController.text,
              );
              ref.read(userViewModelProvider.notifier).updateUser(updatedUser);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.save,
              color: white,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: purpleLite,
            heroTag: 'delete',
            onPressed: () {
              showDeleteConfirmationDialog(context, ref, widget.userId);
            },
            child: Icon(
              Icons.delete,
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}
