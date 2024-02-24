import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

class GetActivePlaceStream
    extends UseCase<ValueStream<ActivePlaceEvent>, NoParams> {
  GetActivePlaceStream({
    required PlacesRepository placesRepository,
    required SettingsRepository settingsRepository,
  })  : _placesRepository = placesRepository,
        _settingsRepository = settingsRepository;

  final PlacesRepository _placesRepository;
  final SettingsRepository _settingsRepository;
  String _activePlaceId = '';
  List<PlaceEntity> _places = [];
  StreamSubscription<SettingsEntity>? _settingsStreamSubscription;
  StreamSubscription<List<PlaceEntity>>? _placesStreamSubscription;

  final _streamController = BehaviorSubject<ActivePlaceEvent>(
    sync: true,
  );

  void _onCancel() {
    _settingsStreamSubscription?.cancel();
    _placesStreamSubscription?.cancel();
  }

  void _settingsHandler(SettingsEntity settings) {
    _activePlaceId = settings.activePlaceId;
    _emitEvent();
  }

  void _placesHandler(List<PlaceEntity> places) {
    _places = places;
    _emitEvent();
  }

  void _errorHandler(dynamic error) {
    _streamController.add(ActivePlaceEvent.failure);
  }

  void _emitEvent() {
    final index = _places.indexWhere((place) => place.id == _activePlaceId);
    if (index == -1) {
      _streamController.add(ActivePlaceEvent.empty);
    } else {
      final event = ActivePlaceEvent(
        entity: _places[index],
        status: ActivePlaceStatus.loaded,
      );
      _streamController.add(event);
    }
  }

  String get _initialPlaceId {
    final initialPlaceId =
        _settingsRepository.settingsStream.valueOrNull?.activePlaceId ??
            SettingsEntity.empty.activePlaceId;
    return initialPlaceId;
  }

  List<PlaceEntity> get _initialPlaces =>
      _placesRepository.placesStream.valueOrNull ?? [];

  @override
  ValueStream<ActivePlaceEvent> call(NoParams params) {
    if (_settingsStreamSubscription == null ||
        _placesStreamSubscription == null) {
      _streamController.add(ActivePlaceEvent.loading);
      _activePlaceId = _initialPlaceId;
      _places = _initialPlaces;
      _emitEvent(); // emit initial event (empty or last active)
      _settingsStreamSubscription ??= _settingsRepository.settingsStream.listen(
        _settingsHandler,
        onError: _errorHandler,
      );
      _placesStreamSubscription ??= _placesRepository.placesStream.listen(
        _placesHandler,
        onError: _errorHandler,
      );
      _streamController.onCancel = _onCancel;
    }
    return _streamController.stream;
  }
}

class ActivePlaceEvent extends Equatable {
  const ActivePlaceEvent({required this.entity, required this.status});

  final PlaceEntity? entity;
  final ActivePlaceStatus status;

  static const loading = ActivePlaceEvent(
    entity: null,
    status: ActivePlaceStatus.loading,
  );

  static const empty = ActivePlaceEvent(
    entity: null,
    status: ActivePlaceStatus.empty,
  );

  static const failure = ActivePlaceEvent(
    entity: null,
    status: ActivePlaceStatus.failure,
  );

  @override
  List<Object?> get props => [entity, status];
}

enum ActivePlaceStatus { loading, loaded, empty, failure }

extension ActivePlaceStatusExtension on ActivePlaceStatus {
  bool get isLoading => this == ActivePlaceStatus.loading;
  bool get isLoaded => this == ActivePlaceStatus.loaded;
  bool get isEmpty => this == ActivePlaceStatus.empty;
  bool get isFailure => this == ActivePlaceStatus.failure;
}
