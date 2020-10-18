// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addCurrentLocation" : MessageLookupByLibrary.simpleMessage("Add current location"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "dateFormat" : MessageLookupByLibrary.simpleMessage("MM/dd/yyyy H:mm"),
    "deleteLocation" : MessageLookupByLibrary.simpleMessage("Delete location?"),
    "infoContent" : MessageLookupByLibrary.simpleMessage("Save location & find your way back (works offline, no network connection needed)"),
    "infoTitle" : MessageLookupByLibrary.simpleMessage("About"),
    "lessThan5Metres" : MessageLookupByLibrary.simpleMessage("Distance less than 5 m"),
    "locationNameTemplate" : MessageLookupByLibrary.simpleMessage("New location №"),
    "metres" : MessageLookupByLibrary.simpleMessage("m"),
    "renameLocationTitle" : MessageLookupByLibrary.simpleMessage("Enter location name"),
    "tipCompass" : MessageLookupByLibrary.simpleMessage("Compass"),
    "tipDeleteLocation" : MessageLookupByLibrary.simpleMessage("Delete location"),
    "tipLocationAccuracy" : MessageLookupByLibrary.simpleMessage("Location accuracy:"),
    "tipRenameLocation" : MessageLookupByLibrary.simpleMessage("Rename location"),
    "tipShareLocation" : MessageLookupByLibrary.simpleMessage("Share location"),
    "warningGPSPermissionDenied" : MessageLookupByLibrary.simpleMessage("Location permission denied"),
    "warningInstruction" : MessageLookupByLibrary.simpleMessage("After saving the current location, you can select it from the list and see it`s direction and distance to it. Also, you can share it with your friends."),
    "warningLocationServiceDisabled" : MessageLookupByLibrary.simpleMessage("Location service is disabled"),
    "warningNoSavedLocations" : MessageLookupByLibrary.simpleMessage("No saved locations."),
    "warningPleasePress" : MessageLookupByLibrary.simpleMessage("Please press "),
    "warningRequestGPSPermission" : MessageLookupByLibrary.simpleMessage("Request permission"),
    "warningToSaveLocation" : MessageLookupByLibrary.simpleMessage(" to save current location."),
    "warningTurnOnLocationService" : MessageLookupByLibrary.simpleMessage("Please turn on location service"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
