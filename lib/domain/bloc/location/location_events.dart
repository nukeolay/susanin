abstract class LocationEvent {}

class LocationEventStart extends LocationEvent {}

class LocationEventPressedSelectLocation extends LocationEvent {
  int index;
  LocationEventPressedSelectLocation(this.index);
}

class LocationEventPressedDeleteLocation extends LocationEvent {
  int index;
  LocationEventPressedDeleteLocation(this.index);
}

class LocationEventPressedRenameLocation extends LocationEvent {
  int index;
  String newName;
  LocationEventPressedRenameLocation(this.index, this.newName);
}

class LocationEventAutoLowAccuracy extends LocationEvent {}

class LocationEventPressedUndoDeletion extends LocationEvent {}

class LocationEventPressedAddNewLocation extends LocationEvent {}

class LocationEventAutoGpsDisabled extends LocationEvent {}

class LocationEventAutoGpsEnabled extends LocationEvent {}