part of '../../location_bottom_sheet.dart';

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.isValid,
    required this.onSave,
  });

  final bool isValid;
  final Function() onSave;

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      type: ButtonType.primary,
      label: context.s.button_save,
      onPressed: isValid ? onSave : null,
    );
  }
}
