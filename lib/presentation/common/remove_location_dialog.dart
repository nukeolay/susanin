import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';
import 'susanin_dialog.dart';

Future<bool> showRemoveConfirmationDialog({
  required BuildContext context,
}) async {
  final result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return SusaninDialog(
            text: context.s.delete_location,
            secondaryButtonLabel: context.s.button_yes,
            onSecondaryTap: () => Navigator.pop(context, true),
            primaryButtonLabel: context.s.button_no,
            onPrimaryTap: () => Navigator.pop(context, false),
          );
        },
      ) ??
      false;
  return result;
}
