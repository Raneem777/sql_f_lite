import 'package:sql_f_lite/model/data.dart';
import 'package:sql_f_lite/viewModel/repo.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  
  Future<void> fetchUsers() async {
    _users = await DatabaseService.getUsers();
    notifyListeners();  
  }

  
  Future<void> addUser(User user) async {
    await DatabaseService.insertUser(user);
    fetchUsers(); 
  }

  
  Future<void> updateUser(User user) async {
    await DatabaseService.updateUser(user);
    fetchUsers(); 
  }

 
  Future<void> deleteUser(int id) async {
    await DatabaseService.deleteUser(id);
    fetchUsers();
  }
}
