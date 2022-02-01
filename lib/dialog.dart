import 'package:flutter/material.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {required String title,
        required String content,
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[

              FlatButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }
}