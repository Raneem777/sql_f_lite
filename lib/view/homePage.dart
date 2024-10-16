import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/bases/baseAppBar.dart';
import 'package:sql_f_lite/reuseablaComponents/showAddDialoge.dart';
import 'package:sql_f_lite/constants/colors.dart';
import 'package:sql_f_lite/constants/texts.dart';
import 'package:sql_f_lite/view/notePage.dart';
import 'package:sql_f_lite/viewModel/userProvider.dart';

class TodoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userViewModelProvider.notifier).fetchUsers();

    final users = ref.watch(userViewModelProvider);
   

    return Scaffold(
      backgroundColor: black,
      appBar: appBarBase(context, "All Notes"),
      body: users.isEmpty
          ? Center(child: emptyNotes)
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 7,
                  mainAxisExtent: 250),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final notes = users[index];
                final containersColors = colors[index % colors.length];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteDetailPage(
                                    userId: notes.id as int,
                                  )));
                    },
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.9,
                      // width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: containersColors,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(
                          notes.title,
                          style: const TextStyle(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          notes.note,
                          maxLines: 9,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: white,
        heroTag: 'add',
        onPressed: () {
          showAddNoteDialog(context, ref);
        },
        child: Icon(
          Icons.add,
          color: purpleLite,
        ),
      ),
    );
  }
}
