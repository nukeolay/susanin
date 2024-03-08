part of '../../location_bottom_sheet.dart';

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      type: ButtonType.secondary,
      label: 'button_cancel'.tr(),
      onPressed: () => Navigator.pop(context),
    );
  }
}
