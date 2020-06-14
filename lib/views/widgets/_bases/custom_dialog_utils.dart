import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';

class DialogUtils {
  static void dialog(BuildContext context, String contents, {Function(BuildContext) onPressed}) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(''),
          content: Text('$contents'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인', style: TextStyle(color: primaryColor)),
              onPressed: onPressed != null
                  ? () => onPressed(dialogContext)
                  : () => Navigator.of(dialogContext).pop()
            ),
          ],
        );
      },
    );
  }

  static void dialogYesOrNo(BuildContext context, String contents, {
    String confirm = '예',
    String cancel = '아니오',
    Function(BuildContext) onConfirm,
    Function(BuildContext) onCancel,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(''),
          content: Text('$contents'),
          actions: <Widget>[
            FlatButton(
                child: Text('$confirm', style: TextStyle(color: primaryColor)),
                onPressed: onConfirm != null
                    ? () => onConfirm(dialogContext)
                    : () => Navigator.of(dialogContext).pop()
            ),
            FlatButton(
                child: Text('$cancel', style: TextStyle(color: primaryColor)),
                onPressed: onCancel != null
                    ? () => onCancel(dialogContext)
                    : () => Navigator.of(dialogContext).pop()
            ),
          ],
        );
      },
    );
  }
}
