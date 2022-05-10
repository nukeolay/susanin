import 'package:susanin/data/wakelock/models/wakelock_model.dart';
import 'package:wakelock/wakelock.dart';

abstract class WakelockPlatform {
  Future<WakelockModel> get wakelock;
  Future<void> enable();
  Future<void> disable();
}

class WakelockPlatformImpl implements WakelockPlatform {
  @override
  Future<WakelockModel> get wakelock async {
    final isEnabled = await Wakelock.enabled;
    return WakelockModel(isEnabled: isEnabled);
  }

  @override
  Future<void> enable() async {
    return await Wakelock.enable();
  }

  @override
  Future<void> disable() async {
    return await Wakelock.disable();
  }
}
