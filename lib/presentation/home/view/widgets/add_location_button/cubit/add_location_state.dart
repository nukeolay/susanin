part of 'add_location_cubit.dart';

enum AddLocationStatus { loading, editing, normal, failure }

class AddLocationState extends Equatable {
  const AddLocationState({
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  final AddLocationStatus status;
  final double latitude;
  final double longitude;
  final String name;

  static const initial = AddLocationState(
    status: AddLocationStatus.loading,
    latitude: 0,
    longitude: 0,
    name: '',
  );

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

  @override
  List<Object> get props => [status, latitude, longitude, name];
}
