import 'package:flutter/material.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_button.dart';

class SettingsOption extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingsOption({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: child,
      ),
    );
  }
}

class ExtraOptions extends StatelessWidget {
  const ExtraOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: 'Дополнительно',
      child: Column(
        children: [
          SettingsButton(
              text: 'Просмотр инструкции',
              action: () => Navigator.of(context).pushNamed(Routes.tutorial)),
          SettingsButton(
              text: 'Поставить оценку приложению',
              action: () {}), // ! TODO add link
        ],
      ),
    );
  }
}
