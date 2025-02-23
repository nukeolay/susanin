import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/presentation/common/back_bar_button.dart';
import 'package:susanin/presentation/common/blurred_scaffold.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/error_details.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/loaded_details.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/loading_details.dart';

class DetailedInfoView extends StatelessWidget {
  const DetailedInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationServiceStatus =
        context.select<DetailedInfoCubit, LocationStatus>(
      (cubit) => cubit.state.locationServiceStatus,
    );
    return BlurredScaffold(
      body: Stack(
        children: [
          if (locationServiceStatus.isFailure)
            ErrorDetails(
              locationServiceStatus: locationServiceStatus,
            )
          else if (locationServiceStatus.isLoading)
            const LoadingDetails()
          else
            const LoadedDetails(),
          Positioned(
            bottom: MediaQuery.of(context).viewPadding.bottom,
            left: 0,
            right: 0,
            child: BackBarButton(
              text: context.s.button_back_to_locations,
            ),
          ),
        ],
      ),
    );
  }
}
