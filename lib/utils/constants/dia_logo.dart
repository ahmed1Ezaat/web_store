import 'package:flutter/material.dart';

class TDiaLogo {
  static defaultDialog({
    required BuildContext context,
    String title = 'Removeal confirmation',
    String content = 'Removeal this data will delete related data',
    String cancelText = 'Cancel',
    String confirmText = 'Remove',
    Function()? onConfirm,
    Function()? onCancel,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  onPressed: onCancel ?? () => Navigator.of(context).pop(),
                  child: Text(cancelText),
                ),
                TextButton(
                  onPressed: onConfirm,
                  child: Text(confirmText),
                )
              ]);
        });
  }
}
