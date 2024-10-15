// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sql_f_lite/constants/colors.dart';
// import 'package:sql_f_lite/view/showAddDialoge.dart';
// import 'package:sql_f_lite/view/showDeleteDialoge.dart';
// import 'package:sql_f_lite/view/showEditDialoge.dart';
// import 'package:sql_f_lite/viewModel/viewModel.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Contacts',
//           style: TextStyle(color: purple),
//         ),
//       ),
//       body: Consumer<UserViewModel>(
//         builder: (context, viewModel, child) {
//           return ListView.builder(
//               itemCount: viewModel.users.length,
//               itemBuilder: (context, index) {
//                 final user = viewModel.users[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.1,
//                     width: MediaQuery.of(context).size.width * 1,
//                     decoration: BoxDecoration(
//                         color: purpleLite,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: ListTile(
//                       title: Text('${user.name.toString()}'),
//                       subtitle: Text('${user.phoneNumber.toString()}'),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit),
//                             onPressed: () {
//                               showEditUserDialog(context, user);
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () {
//                               showDeleteConfirmationDialog(
//                                   context, viewModel, user.id!);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               });
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: purple,
//         onPressed: () {
//           showAddUserDialog(context);
//           ;
//         },
//         child: Icon(
//           Icons.add,
//           color: white,
//         ),
//       ),
//     );
//   }
// }
