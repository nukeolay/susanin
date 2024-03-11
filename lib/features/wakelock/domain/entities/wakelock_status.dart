enum WakelockStatus { enabled, disabled }

extension WakelockStatusExtension on WakelockStatus {
  bool get isEnabled => this == WakelockStatus.enabled;
  bool get isDisabled => this == WakelockStatus.disabled;
}
