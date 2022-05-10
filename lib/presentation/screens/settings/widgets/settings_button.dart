import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ButtonStatus {
  loading,
  failed,
  success,
}

class SettingsButton extends StatelessWidget {
  final String text;
  final ButtonStatus status;
  final VoidCallback? action;
  const SettingsButton({
    Key? key,
    required this.text,
    required this.status,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: status == ButtonStatus.loading
          ? Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade800,
              child: ElevatedButton(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: action,
              ),
            )
          : ElevatedButton(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    status == ButtonStatus.failed
                        ? Colors.red.shade400
                        : Colors.grey),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: action,
            ),
    );
  }
}
