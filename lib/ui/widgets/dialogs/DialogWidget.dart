import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? primaryButtonLabel;
  final String? secondaryButtonLabel;
  final Function? primaryAction;
  final Function? secondaryAction;

  const DialogWidget(
      {required this.title, required this.description, this.primaryButtonLabel, this.secondaryButtonLabel, this.primaryAction, this.secondaryAction});

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          CupertinoDialogAction(
            child: Text(primaryButtonLabel ?? 'OK'),
            onPressed: () {
              if (primaryAction == null) {
                popNotDisposed(context, true);
              } else {
                primaryAction!();
              }
            },
          ),
          if (secondaryAction != null)
            CupertinoDialogAction(
              child: Text(secondaryButtonLabel ?? 'No'),
              onPressed: () {
                secondaryAction!();
              },
            ),
        ],
      );
    } else if (!isIOS) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            child: Text(primaryButtonLabel ?? 'OK'),
            onPressed: () {
              if (primaryAction == null) {
                popNotDisposed(context, true);
              } else {
                primaryAction!();
              }
            },
          ),
          if (secondaryAction != null)
            TextButton(
              child: Text(secondaryButtonLabel ?? 'No'),
              onPressed: () {
                secondaryAction!();
              },
            ),
        ],
      );
    }
    return Container();
  }
}
