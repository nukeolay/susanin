import 'package:flutter/material.dart';
import 'package:susanin/domain/location/entities/location_service_properties.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/usecases/get_location_service_properties.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/internal/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<LocationServicePropertiesEntity> _propertiesFuture;
  late Stream<PositionEntity> _position;
  late LocationServicePropertiesEntity _properties;

  @override
  void initState() {
    _getLocationServiceData();
    super.initState();
  }

  Future<void> _getLocationServiceData() async {
    _propertiesFuture = serviceLocator<GetLocationServiceProperties>().call();
    _properties = await _propertiesFuture;
    // _position = serviceLocator<GetPositionStream>().call();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _propertiesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_properties.isEnabled) {
            return SafeArea(
              child: Scaffold(
                body: Center(
                  child: StreamBuilder<PositionEntity>(
                    stream: _position,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        Future.delayed(const Duration(milliseconds: 1000))
                            .then((value) => setState(() {
                                  _getLocationServiceData();
                                }));
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ERROR in StreamBuilder: ${snapshot.error}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 50,
                              ),
                            ),
                            TextButton(
                              onPressed:
                                  serviceLocator<RequestPermission>.call(),
                              child: const Text('Request Permission'),
                            ),
                          ],
                        );
                      } else if (snapshot.hasData) {
                        return Text(
                          ('longitude: ${snapshot.data!.longitude},\nlatitude: ${snapshot.data!.latitude},\naccuracy: ${snapshot.data!.accuracy}'),
                          style: const TextStyle(fontSize: 20),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            );
          } else if (!_properties.isEnabled) {
            Future.delayed(const Duration(milliseconds: 5000))
                .then((value) => setState(() {
                      _getLocationServiceData();
                    }));
            return const Scaffold(
              body: Center(
                child: Text('Disabled'),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Other'),
              ),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
        }
      },
    );
  }
}
