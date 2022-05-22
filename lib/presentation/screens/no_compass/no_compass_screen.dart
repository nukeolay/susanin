import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoCompassScreen extends StatelessWidget {
  const NoCompassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Компас не обнаружен'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Lottie.asset('assets/animations/compass.json', repeat: false),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Плохие новости',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 30, color: Theme.of(context).errorColor),
                    ),
                    const Text(
                      'К сожалению, приложение не смогло получить доступ к датчику компаса, возможно он отсутствует в данном устройстве.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Хорошие новости',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 30, color: Theme.of(context).primaryColor),
                    ),
                    const Text(
                      'Сусанин все равно работает, правда, без указания направления. Будет показывать только расстояние до сохраненной локации.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
