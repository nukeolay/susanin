enum WakelockStatus {
  enabled,
  disabled;

  bool get isEnabled => this == WakelockStatus.enabled;
  bool get isDisabled => this == WakelockStatus.disabled;
}
