import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/model/data.dart';
import 'package:sql_f_lite/viewModel/databaseService.dart';
import 'package:sql_f_lite/viewModel/viewModel.dart';


// Create the provider for UserViewModel
final userViewModelProvider = StateNotifierProvider<UserViewModel, List<User>>(
  (ref) => UserViewModel(DatabaseService()), 
);
