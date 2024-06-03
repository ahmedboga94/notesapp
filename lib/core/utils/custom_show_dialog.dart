import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

customShowDialog(
    {required BuildContext context,
    required String title,
    required Widget content}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          title: Text(title, style: Theme.of(context).textTheme.labelLarge),
          content: content,
          actions: [
            TextButton(
                child:
                    Text("OK", style: Theme.of(context).textTheme.labelLarge),
                onPressed: () => GoRouter.of(context).pop()),
          ],
        );
      });
}
