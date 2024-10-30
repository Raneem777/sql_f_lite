import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/bases/baseAppBar.dart';
import 'package:sql_f_lite/bases/baseScaffold.dart';
import 'package:sql_f_lite/constants/colors.dart';
import 'package:sql_f_lite/constants/texts.dart';
import 'package:sql_f_lite/notes/repositry/model/data.dart';
import 'package:sql_f_lite/notes/view/notePage.dart';
import 'package:sql_f_lite/notes/viewModel/viewModel.dart';
import 'package:sql_f_lite/reuseablaComponents/showAddDialoge.dart';

class Myhomepage extends ConsumerStatefulWidget {
  const Myhomepage({super.key});

  @override
  ConsumerState<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends ConsumerState<Myhomepage> {
  List<User> notes = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(notesViewModelProvider.notifier).fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    notes = ref.watch(notesViewModelProvider).data?.notess ?? [];
    print(
        "Notes in build-------------------------------------------------------------: $notes");
    return BaseScaffold(
      appBar: appBarBase(
          context,
          "All Notes",
          Icon(
            Icons.note,
            color: white,
          )),
      viewModel: notesViewModelProvider,
      body: notes.isEmpty
          ? Center(child: emptyNotes)
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 7,
                  mainAxisExtent: 250),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final userNotes = notes[index];
                final containersColors = colors[index % colors.length];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteDetailPage(
                                    userId: userNotes.id as int,
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
                          userNotes.title,
                          style: const TextStyle(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          userNotes.note,
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
