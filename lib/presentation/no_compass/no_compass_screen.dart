import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoCompassScreen extends StatelessWidget {
  const NoCompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('compass_not_found'.tr()),
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
                      'no_compass_bad_news_title'.tr(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    Text(
                      'no_compass_bad_news_text'.tr(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'no_compass_good_news_title'.tr(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      'no_compass_good_news_text'.tr(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 18),
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
