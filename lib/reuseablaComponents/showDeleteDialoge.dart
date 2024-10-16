import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/constants/colors.dart';
import 'package:sql_f_lite/constants/texts.dart';
import 'package:sql_f_lite/view/homePage.dart';
import 'package:sql_f_lite/viewModel/userProvider.dart';

Future<void> showDeleteConfirmationDialog(
    BuildContext context, WidgetRef ref, int userId) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: purple,
        title: Text(
          'Confirm Deletion',
          style: textStylee2,
        ),
        content: Text(
          'Are you sure you want to delete this user?',
          style: textStylee3,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              ref.read(userViewModelProvider.notifier).deleteUser(userId);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TodoScreen()));
            },
          ),
        ],
      );
    },
  );
}
