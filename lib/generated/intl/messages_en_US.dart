// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addCurrentLocation" : MessageLookupByLibrary.simpleMessage("Add current location"),
    "buttonCancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "buttonDelete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "buttonRename" : MessageLookupByLibrary.simpleMessage("Rename"),
    "buttonRequestPermission" : MessageLookupByLibrary.simpleMessage("Request permission"),
    "buttonShare" : MessageLookupByLibrary.simpleMessage("Share"),
    "checkingPermission" : MessageLookupByLibrary.simpleMessage("Checking permission"),
    "compass" : MessageLookupByLibrary.simpleMessage("compass"),
    "dateFormat" : MessageLookupByLibrary.simpleMessage("MM/dd/yyyy H:mm"),
    "kilometres" : MessageLookupByLibrary.simpleMessage("km"),
    "lessThan5Metres" : MessageLookupByLibrary.simpleMessage("Less than 5 m"),
    "locationAccuracy" : MessageLookupByLibrary.simpleMessage("accuracy"),
    "locationEmptyList1" : MessageLookupByLibrary.simpleMessage("Press "),
    "locationEmptyList2" : MessageLookupByLibrary.simpleMessage("\"Add location\""),
    "locationEmptyList3" : MessageLookupByLibrary.simpleMessage(" button to save current location\n\nAfter saving the current location, you can select it from the list and see it`s direction and distance to it"),
    "locationNameTemplate" : MessageLookupByLibrary.simpleMessage("New location №"),
    "locationPermissionDenied" : MessageLookupByLibrary.simpleMessage("Trying to get access to location service.\nIf you see this message longer than 10 sec, press button\n"),
    "locationPermissionDeniedForever" : MessageLookupByLibrary.simpleMessage("Susanin does not have access to location service"),
    "locationServiceDisabled" : MessageLookupByLibrary.simpleMessage("Location service disabled, please turn on location service"),
    "metres" : MessageLookupByLibrary.simpleMessage("m"),
    "noCompass" : MessageLookupByLibrary.simpleMessage("No compass detected"),
    "noSavedLocations" : MessageLookupByLibrary.simpleMessage("No saved locations"),
    "permissionDenied" : MessageLookupByLibrary.simpleMessage("Permission Denied"),
    "renameLocationTitle" : MessageLookupByLibrary.simpleMessage("Enter location name"),
    "serviceDisabled" : MessageLookupByLibrary.simpleMessage("Service Disabled")
  };
}
