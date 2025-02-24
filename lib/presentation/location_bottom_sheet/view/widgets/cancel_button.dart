import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../common/susanin_button.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SusaninButton(
      type: ButtonType.secondary,
      label: context.s.button_cancel,
      onPressed: () => Navigator.pop(context),
    );
  }
}
