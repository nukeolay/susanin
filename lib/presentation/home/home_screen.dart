import 'package:flutter/material.dart';
import 'package:susanin/domain/position/entities/position.dart';
import 'package:susanin/domain/position/usecases/get_position_stream.dart';
import 'package:susanin/internal/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: StreamBuilder<PositionEntity>(
            stream: serviceLocator<GetPositionStream>().call(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  ('longitude: ${snapshot.data!.longitude},\nlatitude: ${snapshot.data!.latitude},\naccuracy: ${snapshot.data!.accuracy}'),
                  style: TextStyle(fontSize: 20),
                );
              } else if (snapshot.hasError) {
                return Text(
                  'ERROR: ${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 50,
                  ),
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
