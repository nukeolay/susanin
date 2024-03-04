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
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        foregroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.inversePrimary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: isValid ? onSave : null,
      child: Text('button_save'.tr()),
    );
  }
}
