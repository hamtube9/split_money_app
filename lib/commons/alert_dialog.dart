import 'package:flutter/cupertino.dart';

class AlertPopup {
  final String title, msg;
  final String? confirmText, declinedText;
  final Function()? confirmAction;
  final DeclinedAction? declinedAction;

  AlertPopup(
      {this.confirmText,
        this.declinedText,
        this.confirmAction,
        required this.title,
        required this.msg,
        this.declinedAction});

  // Show popup
  showAlertPopup(BuildContext context) async {
    await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              if (confirmText != null)
                CupertinoDialogAction(
                  onPressed: confirmAction,
                  child: Text(
                    confirmText!,
                  ),
                ),
              CupertinoDialogAction(
                child: Text(
                  declinedText ?? "Cancel",
                ),
                onPressed: () {
                  if (declinedAction == null) {
                Navigator.of(context).pop();
                  } else {
                    declinedAction!();
                  }
                },
              )
            ],
          );
        });
  }
}

typedef DeclinedAction = Function();