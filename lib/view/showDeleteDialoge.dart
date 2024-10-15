 import 'package:flutter/material.dart';
import 'package:sql_f_lite/viewModel/viewModel.dart';

Future<void> showDeleteConfirmationDialog(BuildContext context, UserViewModel viewModel, int userId) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title:const Text('Confirm Deletion'),
          content:const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              child:const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); 
              },
            ),
            TextButton(
              child:const Text('Delete'),
              onPressed: () {
                viewModel.deleteUser(userId); 
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }