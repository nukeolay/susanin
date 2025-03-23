part of 'add_location_cubit.dart';

enum AddLocationStatus { loading, editing, normal, failure }

class AddLocationState extends Equatable {
  const AddLocationState({
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.notes,
    required this.name,
    required this.icon,
  });

  AddLocationState.initial(PlaceEntity place)
      : this(
          status: AddLocationStatus.loading,
          latitude: place.latitude,
          longitude: place.longitude,
          notes: place.notes,
          name: place.name,
          icon: place.icon,
        );

  final AddLocationStatus status;
  final double latitude;
  final double longitude;
  final String notes;
  final String name;
  final IconEntity icon;

  AddLocationState copyWith({
    AddLocationStatus? status,
    double? latitude,
    double? longitude,
    String? notes,
    String? name,
    IconEntity? icon,
  }) {
    return AddLocationState(
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      notes: notes ?? this.notes,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  @override
  List<Object> get props => [
        status,
        latitude,
        longitude,
        name,
        notes,
        icon,
      ];
}
