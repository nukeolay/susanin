import 'package:flutter/material.dart';

import '../../../common/remove_location_dialog.dart';

class RemoveButton extends StatelessWidget {
  const RemoveButton({required this.onRemove});
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_forever_rounded),
      onPressed: () async {
        final wasConfirmed = await showRemoveConfirmationDialog(
          context: context,
        );
        if (wasConfirmed) onRemove();
      },
    );
  }
}
