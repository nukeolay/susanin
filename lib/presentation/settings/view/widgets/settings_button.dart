import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final VoidCallback? action;
  const SettingsButton({
    required this.text,
    required this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: ElevatedButton(
          style: ButtonStyle(
            alignment: Alignment.center,
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).cardColor),
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(18.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: action,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
