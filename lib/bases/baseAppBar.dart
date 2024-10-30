import 'package:flutter/material.dart';
import 'package:sql_f_lite/constants/texts.dart';

PreferredSizeWidget appBarBase(context, String title, Widget button) {
  return AppBar(
    title: Text(
      title,
      style: textStylee,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: button,
      )
    ],
    // backgroundColor: black,
    // centerTitle: true,
  );
}
