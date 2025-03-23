import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../common/susanin_button.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    required this.isValid,
    required this.onSave,
    super.key,
  });

  final bool isValid;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return SusaninButton(
      type: ButtonType.primary,
      label: context.s.button_save,
      onPressed: isValid ? onSave : null,
    );
  }
}
