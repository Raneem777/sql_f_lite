import 'package:flutter/material.dart';
import 'package:sql_f_lite/constants/colors.dart';
import 'package:sql_f_lite/constants/texts.dart';

PreferredSizeWidget appBarBase(context, String title) {
  return AppBar(
    title: Text(
      title,
      style: textStylee,
    ),
    backgroundColor: black,
    // centerTitle: true,
  );
}
