import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/features/location/domain/entities/position.dart';

class ErrorDetails extends StatelessWidget {
  const ErrorDetails({
    required this.locationServiceStatus,
    super.key,
  });
  final LocationStatus locationServiceStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.primary,
          highlightColor: Theme.of(context).colorScheme.error,
          child: Text(
            locationServiceStatus.toErrorMessage(context) ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 60),
          ),
        ),
      ],
    );
  }
}
