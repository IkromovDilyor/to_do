import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCupertinoDeleteDialog(BuildContext context, VoidCallback onConfirm) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text("Delete Dialog?"),
      content: Text("Are you sure delete?"),
      actions: [
        CupertinoDialogAction(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text("Yes"),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

void showMaterialDeleteDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Task?'),
      content: const Text('Are you sure you want to delete this task?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text('Yes', style: TextStyle(color: Colors.red)),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
