import 'package:equatable/equatable.dart';

enum AddLocationStatus { loading, editing, normal, failure }

class AddLocationState extends Equatable {
  final AddLocationStatus status;
  final double latitude;
  final double longitude;
  final String name;

  const AddLocationState({
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  @override
  List<Object> get props => [status, latitude, longitude, name];

  AddLocationState copyWith({
    AddLocationStatus? status,
    double? latitude,
    double? longitude,
    String? name,
  }) {
    return AddLocationState(
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
    );
  }
}
