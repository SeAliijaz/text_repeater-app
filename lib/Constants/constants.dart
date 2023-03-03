import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

///function to copy text
void copy(String? text) {
  FlutterClipboard.copy(text ?? "text");
}

void send(String? text) {
  Share.share(text ?? "text");
}

void showToast(String? text) {
  Fluttertoast.showToast(msg: text ?? "text");
}
