import 'package:sql_f_lite/bases/baseProviderState.dart';
import 'package:sql_f_lite/bases/baseViewModel.dart';
import 'package:sql_f_lite/bases/baseViewState.dart';
import 'package:sql_f_lite/notes/repositry/model/data.dart';
import 'package:sql_f_lite/notes/viewModel/databaseService.dart';

final notesViewModelProvider = BaseStateProvider<NoteViewState, NoteViewModel>(
    (ref) => NoteViewModel(ref.watch(noteDataBaseClient)));

class NoteViewState {
  final List<User> notess;

  NoteViewState(this.notess);
}

class NoteViewModel extends BaseViewModel<NoteViewState> {
  final DataBaseClient repo;

  NoteViewModel(this.repo) : super(BaseViewState(data: NoteViewState([]))) {
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      //isLoading = true;
      final notes = await repo.getnotes();
      print("Fetched notes: $notes");
      // isLoading = false;
      data = NoteViewState(notes);
    } catch (error) {
      this.error = BaseError("Failed to load notes", type: ErrorType.error);
      print("Error fetching notes: $error");
      isLoading = false;
    }
  }

  Future<int> addUser(User user) async {
    try {
      isLoading = true;
      User newNote = User(title: user.title, note: user.note);
      await repo.insertNotes(newNote);
      isLoading = false;
      return 200;
      //await fetchNotes();
    } catch (e) {
      isLoading = false;
      print("Error inserting user: $e");
      return 400;
    }
  }

  Future<void> updateUser(User user) async {
    isLoading = true;
    await repo.updateNotes(user);
    fetchNotes();
    isLoading = false;
  }

  Future<void> deleteUser(int id) async {
    isLoading = true;
    await repo.deleteNotes(id);
    fetchNotes();
    isLoading = false;
  }

  User? getUserById(int id) {
    if (state.data != null) {
      try {
        return state.data!.notess.firstWhere((user) => user.id == id);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
