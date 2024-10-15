import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_f_lite/constants/textControllers.dart';
import 'package:sql_f_lite/model/data.dart';
import 'package:sql_f_lite/viewModel/viewModel.dart';

Future<void> showAddUserDialog(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Add Contact'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 0) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, proceed with adding the user
                String name = nameController.text;
                int phoneNumber = int.tryParse(phoneNumberController.text) ?? 0;

                // Add the user through ViewModel
                User user = User(name: name, phoneNumber: phoneNumber);
                Provider.of<UserViewModel>(context, listen: false)
                    .addUser(user);

                // Clear the fields and close the dialog
                nameController.clear();
                phoneNumberController.clear();
                Navigator.of(dialogContext).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
