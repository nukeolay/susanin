import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final VoidCallback? action;
  const SettingsButton({
    Key? key,
    required this.text,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ElevatedButton(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 16,
            ),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).cardColor),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: action,
        ),
      ),
    );
  }
}
