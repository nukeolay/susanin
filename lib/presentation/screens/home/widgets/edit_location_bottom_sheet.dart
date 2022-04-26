import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_state.dart';

class EditLocationBottomSheet extends StatelessWidget {
  final AddLocationState state;
  const EditLocationBottomSheet({Key? key, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Edit Location'),
            Text('lat: ${state.latitude}, lon: ${state.longitude}'),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: state.pointName,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  TextFormField(
                    initialValue: state.latitude.toString(),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  TextFormField(
                    initialValue: state.longitude.toString(),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  context.read<AddLocationCubit>().onSaveLocation(
                        latitude: state.latitude,
                        longitude: state.longitude,
                        pointName: 'saved ${DateTime.now()}',
                      );
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
