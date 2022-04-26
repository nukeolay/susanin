import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_state.dart';
import 'package:susanin/presentation/screens/home/widgets/edit_location_bottom_sheet.dart';

class AddNewLocationButton extends StatelessWidget {
  const AddNewLocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLocationCubit, AddLocationState>(
      builder: ((context, state) {
        if (state.status == AddLocationStatus.editing) {
          return const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.green,
            child: LinearProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (state.status == AddLocationStatus.loading) {
          return const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.green,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (state.status == AddLocationStatus.failure) {
          return const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.grey,
            child: Icon(Icons.not_interested_rounded),
          );
        }
        return GestureDetector(
          onLongPress: () {
            _showBottomSheet(context, state);
            context.read<AddLocationCubit>().onAddLongPress();
          },
          child: FloatingActionButton(
            onPressed: () => context.read<AddLocationCubit>().onAddTap(),
            backgroundColor: Colors.green,
            child: const Icon(Icons.add_location_alt_rounded),
          ),
        );
      }),
    );
  }

  void _showBottomSheet(BuildContext context, AddLocationState state) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return EditLocationBottomSheet(state: state);
      },
    );
    context.read<AddLocationCubit>().onCancel();
  }
}
