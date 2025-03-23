import 'package:rxdart/rxdart.dart';

import '../services/wakelock_service.dart';
import '../../domain/entities/wakelock_status.dart';
import '../../domain/repositories/wakelock_repository.dart';

class WakelockRepositoryImpl implements WakelockRepository {
  WakelockRepositoryImpl(this._wakelockService);

  final WakelockService _wakelockService;
  BehaviorSubject<WakelockStatus>? _streamController;

  @override
  ValueStream<WakelockStatus> get wakelockStream {
    final controller = _streamController ??= _initStreamController();
    return controller.stream;
  }

  BehaviorSubject<WakelockStatus> _initStreamController() {
    final streamController = BehaviorSubject<WakelockStatus>();
    _wakelockStatus.then(_updateStatus);
    return streamController;
  }

  @override
  Future<WakelockStatus> toggle() async {
    final status = await _wakelockStatus;
    if (status.isEnabled) {
      await _wakelockService.disable();
      _updateStatus(WakelockStatus.disabled);
      return WakelockStatus.disabled;
    } else {
      await _wakelockService.enable();
      _updateStatus(WakelockStatus.enabled);
      return WakelockStatus.enabled;
    }
  }

  WakelockStatus _updateStatus(WakelockStatus status) {
    final currentStatus = wakelockStream.valueOrNull;
    if (currentStatus != status) {
      _streamController?.add(status);
    }
    return status;
  }

  Future<WakelockStatus> get _wakelockStatus async {
    try {
      final wackelockStatus = await _wakelockService.wakelock;
      return wackelockStatus;
    } catch (error) {
      return WakelockStatus.disabled;
    }
  }
}
