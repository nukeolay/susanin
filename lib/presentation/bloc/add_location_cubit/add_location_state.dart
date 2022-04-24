import 'package:equatable/equatable.dart';

enum AddLocationStatus { loading, editing, normal, failure }

class AddLocationState extends Equatable {
  final AddLocationStatus status;
  final double latitude;
  final double longitude;
  final String pointName;

  const AddLocationState({
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.pointName,
  });

  @override
  List<Object> get props => [status, latitude, longitude, pointName];

  AddLocationState copyWith({
    AddLocationStatus? status,
    double? latitude,
    double? longitude,
    String? pointName,
  }) {
    return AddLocationState(
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      pointName: pointName ?? this.pointName,
    );
  }
}
