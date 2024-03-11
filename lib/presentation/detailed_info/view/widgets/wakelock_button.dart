import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/presentation/common/susanin_snackbar.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';

class DetailedWakelockButton extends StatelessWidget {
  const DetailedWakelockButton({super.key});

  Future<void> _toggleWakelock(BuildContext context) async {
    await context.read<DetailedInfoCubit>().toggleWakelock();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isScreenAlwaysOn =
          context.read<DetailedInfoCubit>().state.isScreenAlwaysOn;
      final snackBar = SusaninSnackBar(
        content: isScreenAlwaysOn
            ? Text(
                context.s.always_on_display_on,
                textAlign: TextAlign.center,
              )
            : Text(
                context.s.always_on_display_off,
                textAlign: TextAlign.center,
              ),
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isScreenAlwaysOn = context.select<DetailedInfoCubit, bool>(
      (cubit) => cubit.state.isScreenAlwaysOn,
    );
    return IconButton(
      onPressed: () => _toggleWakelock(context),
      enableFeedback: true,
      tooltip: context.s.always_on_display,
      icon: isScreenAlwaysOn
          ? const Icon(Icons.lightbulb)
          : const Icon(Icons.lightbulb_outline),
    );
  }
}
