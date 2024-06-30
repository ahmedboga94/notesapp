import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notesapp/core/app_translate_keys.dart';

confirmToDelete(
    {required BuildContext context, required void Function() onPressed}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          content: Text(context.deleteDescrpKey,
              style: Theme.of(context).textTheme.labelLarge),
          actions: [
            TextButton(
                child: Text(context.cancelKey,
                    style: Theme.of(context).textTheme.labelLarge),
                onPressed: () => GoRouter.of(context).pop()),
            TextButton(
                onPressed: onPressed,
                child: Text(context.okKey,
                    style: Theme.of(context).textTheme.labelLarge)),
          ],
        );
      });
}
