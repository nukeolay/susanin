import 'package:flutter/material.dart';

import 'package:susanin/presentation/common/susanin_button.dart';
import 'package:susanin/presentation/common/susanin_dialog_shell.dart';

class SusaninDialog extends StatelessWidget {
  const SusaninDialog({
    required this.text,
    required this.primaryButtonLabel,
    required this.onPrimaryTap,
    this.secondaryButtonLabel,
    this.onSecondaryTap,
    super.key,
  });

  final String text;
  final String primaryButtonLabel;
  final void Function() onPrimaryTap;
  final String? secondaryButtonLabel;
  final void Function()? onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    return SusaninDialogShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (secondaryButtonLabel != null)
                Expanded(
                  child: SusaninButton(
                    type: ButtonType.secondary,
                    label: secondaryButtonLabel!,
                    onPressed: onSecondaryTap,
                  ),
                ),
              if (secondaryButtonLabel != null)
                const SizedBox(width: 16),
              Expanded(
                child: SusaninButton(
                  type: ButtonType.primary,
                  label: primaryButtonLabel,
                  onPressed: onPrimaryTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
