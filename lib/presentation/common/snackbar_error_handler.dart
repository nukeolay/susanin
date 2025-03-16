import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'susanin_snackbar.dart';

class SnackBarErrorHandler {
  const SnackBarErrorHandler(this.context, {this.message});
  final BuildContext context;
  final String? message;

  void onError(error, stackTrace) {
    ScaffoldMessenger.of(context).showSnackBar(
      SusaninSnackBar(
        content: Text(message ?? S.of(context).snack_bar_error_default_text),
      ),
    );
  }
}
