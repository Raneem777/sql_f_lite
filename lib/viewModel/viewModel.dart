import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/model/data.dart';
import 'package:sql_f_lite/viewModel/databaseService.dart';

class UserViewModel extends StateNotifier<List<User>> {
  final DatabaseService databaseService;

  UserViewModel(this.databaseService) : super([]) {
    fetchUsers(); // Load users initially
  }

  Future<void> fetchUsers() async {
    final users = await databaseService.getnotes();
    state = users;
  }

  Future<void> addUser(User user) async {
    await databaseService.insertNotes(user);
    fetchUsers(); // Refresh after adding
  }

  Future<void> updateUser(User user) async {
    await databaseService.updateNotes(user);
    fetchUsers(); // Refresh after updating
  }

  Future<void> deleteUser(int id) async {
    await databaseService.deleteNotes(id);
    fetchUsers(); // Refresh after deleting
  }

  // Add getUserById function
  User? getUserById(int id) {
    try {
      return state.firstWhere((user) => user.id == id);
    } catch (e) {
      return null; // Return null if user is not found
    }
  }
}
