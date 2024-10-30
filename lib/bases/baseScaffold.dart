import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/bases/baseProviderState.dart';
import 'package:sql_f_lite/utils/dialogs.dart';

class BaseScaffold extends ConsumerStatefulWidget {
  const BaseScaffold({
    required this.body,
     required this.floatingActionButton,
    required this.viewModel,
    this.padding,
    this.appBar,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final FloatingActionButton floatingActionButton;
  final EdgeInsetsGeometry? padding;
  final BaseStateProvider viewModel;
  final PreferredSizeWidget? appBar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseScaffold();
}

class _BaseScaffold extends ConsumerState<BaseScaffold> {

  @override
  Widget build(BuildContext context) {
    ref.listen(widget.viewModel, (previous, next) {
  if (next.isLoading == true) {
    showLoading();
  } else if (previous?.isLoading == true && next.isLoading != true) {
    Navigator.pop(context);
  }

  // Check if there's data or error before proceeding
  if (next.hasError) {
    showError(next.error!);
  }
});


    return Scaffold(
     
      appBar: widget.appBar,
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
