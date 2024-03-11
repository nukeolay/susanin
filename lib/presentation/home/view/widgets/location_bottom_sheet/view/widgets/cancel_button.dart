part of '../../location_bottom_sheet.dart';

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return SusaninButton(
      type: ButtonType.secondary,
      label: context.s.button_cancel,
      onPressed: () => Navigator.pop(context),
    );
  }
}
