import 'package:susanin/features/wakelock/domain/entities/wakelock_status.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract class WakelockService {
  const WakelockService();

  Future<WakelockStatus> get wakelock;
  Future<void> enable();
  Future<void> disable();
}

class WakelockServiceImpl implements WakelockService {
  const WakelockServiceImpl();

  @override
  Future<WakelockStatus> get wakelock async {
    final isEnabled = await WakelockPlus.enabled;
    return isEnabled ? WakelockStatus.enabled : WakelockStatus.disabled;
  }

  @override
  Future<void> enable() async {
    return await WakelockPlus.enable();
  }

  @override
  Future<void> disable() async {
    return await WakelockPlus.disable();
  }
}
