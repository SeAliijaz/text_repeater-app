import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

///function to copy text
void copy(String? text) {
  FlutterClipboard.copy(text == null ? text ?? "Null Text" : "Text");
}

void send(String? text) {
  Share.share(text == null ? text ?? "Null Text" : "Text");
}

void showToast(String? text) {
  Fluttertoast.showToast(msg: text == null ? text ?? "Null Text" : "Text");
}
