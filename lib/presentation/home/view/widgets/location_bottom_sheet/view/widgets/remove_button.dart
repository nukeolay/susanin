part of '../../location_bottom_sheet.dart';

class _RemoveButton extends StatelessWidget {
  const _RemoveButton({required this.onRemove});
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SusaninIconButton(
      type: ButtonType.secondary,
      icon: Icons.delete_forever_rounded,
      onPressed: () async {
        final wasConfirmed = await showRemoveConfirmationDialog(
          context: context,
        );
        // TODO(nukeolay): проверить удаление
        if (wasConfirmed) onRemove();
      },
    );
  }
}
