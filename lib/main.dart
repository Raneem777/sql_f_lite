import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_f_lite/view/home.dart';
import 'package:sql_f_lite/viewModel/viewModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (_) => UserViewModel()..fetchUsers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Home()
      )
    );
  }
}

