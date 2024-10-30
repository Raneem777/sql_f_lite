import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_f_lite/bases/baseViewModel.dart';
import 'package:sql_f_lite/bases/baseViewState.dart';

typedef BaseStateProvider<S, V extends BaseViewModel<S>>
    = StateNotifierProvider<V, BaseViewState<S>>;
