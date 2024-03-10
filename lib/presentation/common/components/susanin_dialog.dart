import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:susanin/presentation/common/components/susanin_button.dart';

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
              ),
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
            ),
          ),
        ),
      ),
    );
  }
}
