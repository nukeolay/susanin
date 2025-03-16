// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(meters) => "${meters} km";

  static String m1(meters) => "${meters} m";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accuracy_details":
            MessageLookupByLibrary.simpleMessage("location accuracy: "),
        "always_on_display":
            MessageLookupByLibrary.simpleMessage("Always on display"),
        "always_on_display_off": MessageLookupByLibrary.simpleMessage(
            "Display auto turn off enabled"),
        "always_on_display_on": MessageLookupByLibrary.simpleMessage(
            "Display auto turn off disabled"),
        "button_allow": MessageLookupByLibrary.simpleMessage("Allow"),
        "button_back_to_locations":
            MessageLookupByLibrary.simpleMessage("Back to locations list"),
        "button_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "button_deny": MessageLookupByLibrary.simpleMessage("Deny"),
        "button_edit_location": MessageLookupByLibrary.simpleMessage("Edit"),
        "button_hide": MessageLookupByLibrary.simpleMessage("Hide"),
        "button_instruction":
            MessageLookupByLibrary.simpleMessage("Instruction"),
        "button_next": MessageLookupByLibrary.simpleMessage("Next"),
        "button_no": MessageLookupByLibrary.simpleMessage("No"),
        "button_save": MessageLookupByLibrary.simpleMessage("Save"),
        "button_select": MessageLookupByLibrary.simpleMessage("Select"),
        "button_start": MessageLookupByLibrary.simpleMessage("Start"),
        "button_yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "compass_calibrate_instruction": MessageLookupByLibrary.simpleMessage(
            "Move the phone several times in space as shown on the screen to calibrate compass."),
        "compass_not_found":
            MessageLookupByLibrary.simpleMessage("Compass not found"),
        "copied": MessageLookupByLibrary.simpleMessage("Copied"),
        "current_location":
            MessageLookupByLibrary.simpleMessage("current location"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Dark theme"),
        "date_format": MessageLookupByLibrary.simpleMessage("MM-dd-yyyy"),
        "delete_location":
            MessageLookupByLibrary.simpleMessage("Delete location?"),
        "distance_kilometers": m0,
        "distance_meters": m1,
        "empty_locations_list": MessageLookupByLibrary.simpleMessage(
            "No saved locations.\n\nAfter saving the current location, you can select it from the list and get it`s direction and distance to it"),
        "empty_locations_list_header":
            MessageLookupByLibrary.simpleMessage(" "),
        "enter_name":
            MessageLookupByLibrary.simpleMessage("Please enter location name"),
        "error_geolocation_disabled": MessageLookupByLibrary.simpleMessage(
            "Geolocation service disabled."),
        "error_geolocation_permission":
            MessageLookupByLibrary.simpleMessage("Permission not granted."),
        "error_geolocation_permission_short":
            MessageLookupByLibrary.simpleMessage("Permission not granted"),
        "error_title": MessageLookupByLibrary.simpleMessage("Error"),
        "error_unknown": MessageLookupByLibrary.simpleMessage("Unknown error"),
        "geolocation_permission":
            MessageLookupByLibrary.simpleMessage("Request permission"),
        "has_compass":
            MessageLookupByLibrary.simpleMessage("Compass availability"),
        "incorrect_value":
            MessageLookupByLibrary.simpleMessage("Incorrect value"),
        "ios_compass_settings_info": MessageLookupByLibrary.simpleMessage(
            "If the direction pointer does not rotate when you move your phone, you need to enable compass calibration:\nSettings -> Privacy -> Location Services -> System Services -> Compass Calibration."),
        "latitude": MessageLookupByLibrary.simpleMessage("latitude"),
        "less_than_5_m": MessageLookupByLibrary.simpleMessage("less than 5 m"),
        "location_default_name":
            MessageLookupByLibrary.simpleMessage("location"),
        "location_name": MessageLookupByLibrary.simpleMessage("location name"),
        "longitude": MessageLookupByLibrary.simpleMessage("longitude"),
        "low_compass_accuracy":
            MessageLookupByLibrary.simpleMessage("Poor compass accuracy: "),
        "no_compass_accuracy":
            MessageLookupByLibrary.simpleMessage("Location\naccuracy: "),
        "no_compass_bad_news_text": MessageLookupByLibrary.simpleMessage(
            "Unfortunately, the application could not access the compass sensor, it may not be available in this device."),
        "no_compass_bad_news_title":
            MessageLookupByLibrary.simpleMessage("Bad news"),
        "no_compass_distance_to_point":
            MessageLookupByLibrary.simpleMessage("Distance to\nlocation: "),
        "no_compass_good_news_text": MessageLookupByLibrary.simpleMessage(
            "Susanin still works, however, without indicating the direction. Will only show the distance to the target location."),
        "no_compass_good_news_title":
            MessageLookupByLibrary.simpleMessage("Good news"),
        "normal_compass_accuracy":
            MessageLookupByLibrary.simpleMessage("Good compass accuracy: "),
        "notes": MessageLookupByLibrary.simpleMessage("notes"),
        "permission_request": MessageLookupByLibrary.simpleMessage(
            "Allow Susanin to access your location?"),
        "review_button": MessageLookupByLibrary.simpleMessage("Rate the app"),
        "review_error":
            MessageLookupByLibrary.simpleMessage("Could not open app store"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "snack_bar_error_default_text":
            MessageLookupByLibrary.simpleMessage("An error occurred"),
        "title": MessageLookupByLibrary.simpleMessage("Susanin"),
        "tutorial_settings_disabled": MessageLookupByLibrary.simpleMessage(
            "LOCATION SERVICE OFF\n\nPlease turn on the location service to continue."),
        "tutorial_settings_no_compass": MessageLookupByLibrary.simpleMessage(
            "Unfortunately, the application was not allowed to access the compass, so Susanin will not be able to indicate the direction to the target, it will only show the distance to target location."),
        "tutorial_settings_permission": MessageLookupByLibrary.simpleMessage(
            "Acces to gelocation service is required."),
        "tutorial_text_1": MessageLookupByLibrary.simpleMessage(
            "I\'ll help you find the path to the saved location.\n\nNo maps or internet access required. Only permission to get your location and compass sensor in this device.\n\nOn the next screen, you can grant the necessary permissions."),
        "tutorial_text_3": MessageLookupByLibrary.simpleMessage(
            "If all necessary permissions is granted and the compass in the device is working correctly, the pointer shows the direct direction to Hollywood and the distance to it.\n\nNow you can save the location you are in to find your way back to it."),
        "tutorial_title_1": MessageLookupByLibrary.simpleMessage("Hello!"),
        "tutorial_title_2": MessageLookupByLibrary.simpleMessage("Settings"),
        "tutorial_title_3":
            MessageLookupByLibrary.simpleMessage("Follow Susanin!")
      };
}
