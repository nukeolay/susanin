import 'package:flutter/material.dart';

class SlideTile extends StatelessWidget {
  const SlideTile({
    required this.title,
    required this.topContent,
    required this.bottomContent,
    required this.height,
    super.key,
  });

  final String title;
  final Widget topContent;
  final Widget bottomContent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: topContent,
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.only(
              left: height * 0.015,
              right: height * 0.015,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    bottomContent,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
