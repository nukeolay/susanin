import 'package:flutter/material.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/internal/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: StreamBuilder<PositionEntity>(
            stream: serviceLocator<GetPositionStream>().call(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  ('longitude: ${snapshot.data!.longitude},\nlatitude: ${snapshot.data!.latitude},\naccuracy: ${snapshot.data!.accuracy}'),
                  style: const TextStyle(fontSize: 20),
                );
              } else if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ERROR: ${snapshot.error}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 50,
                      ),
                    ),
                    TextButton(
                      onPressed: serviceLocator<RequestPermission>.call(),
                      child: const Text('Request Permission'),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
