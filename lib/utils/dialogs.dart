import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/bases/baseViewState.dart';
import 'package:sql_f_lite/bases/errorDialog.dart';
import 'package:sql_f_lite/bases/loadingDialog.dart';

extension Dialogs on ConsumerState {
  void showLoading() {
    if (mounted) {  // Check if the widget is still mounted
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const LoadingDialog();
        },
      );
    }
  }

  void showError(BaseError error) {
    if (mounted) {  // Check if the widget is still mounted
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            error: error,
          );
        },
      );
    }
  }
}
