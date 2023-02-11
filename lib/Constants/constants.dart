import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

///function to copy text
copy(String text) {
  FlutterClipboard.copy(text);
}

///Snackbar
void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
