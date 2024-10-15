import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_f_lite/model/data.dart';
import 'package:sql_f_lite/viewModel/viewModel.dart';

Future<void> showEditUserDialog(BuildContext context, User user) async {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController =
      TextEditingController(text: user.name);
  TextEditingController _phoneNumberController =
      TextEditingController(text: user.phoneNumber.toString());

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Edit User'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Phone number';
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
                  String name = _nameController.text;
                  int phoneNumber = int.tryParse(_phoneNumberController.text) ??
                      user.phoneNumber;

                  User updatedUser =
                      User(id: user.id, name: name, phoneNumber: phoneNumber);
                  Provider.of<UserViewModel>(context, listen: false)
                      .updateUser(updatedUser);

                  _nameController.clear();
                  _phoneNumberController.clear();
                  Navigator.of(dialogContext).pop();
                }
              }),
        ],
      );
    },
  );
}
