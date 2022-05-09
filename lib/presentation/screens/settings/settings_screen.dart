import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SettingsOption(
              title: 'Оформление',
              details: 'Тема (светлая / темная)',
              child: CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.black,
              ),
            ),
            const SettingsOption(
              title: 'Доступ к геолокации',
              details: 'Не предоставлен',
              child: CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.red,
              ),
            ),
            const SettingsOption(
              title: 'Наличие компаса',
              details: 'Присутствует',
              child: CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.green,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Инструкция'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final String details;
  final Widget child;

  const SettingsOption({
    Key? key,
    required this.title,
    required this.details,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(details),
              child,
            ],
          )
        ],
      ),
    );
  }
}
