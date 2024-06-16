import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notesapp/core/app_translate_keys.dart';

customShowDialog(
    {required BuildContext context,
    required String title,
    required Widget content,
    bool isConfirm = true}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          title: Text(title, style: Theme.of(context).textTheme.labelLarge),
          content: content,
          actions: isConfirm
              ? [
                  TextButton(
                      child: Text(context.okKey,
                          style: Theme.of(context).textTheme.labelLarge),
                      onPressed: () => GoRouter.of(context).pop()),
                ]
              : [],
        );
      });
}
