// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Susanin`
  String get title {
    return Intl.message(
      'Susanin',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `location accuracy: `
  String get accuracy_details {
    return Intl.message(
      'location accuracy: ',
      name: 'accuracy_details',
      desc: '',
      args: [],
    );
  }

  /// `current location`
  String get current_location {
    return Intl.message(
      'current location',
      name: 'current_location',
      desc: '',
      args: [],
    );
  }

  /// `Back to locations list`
  String get button_back_to_locations {
    return Intl.message(
      'Back to locations list',
      name: 'button_back_to_locations',
      desc: '',
      args: [],
    );
  }

  /// `latitude`
  String get latitude {
    return Intl.message(
      'latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `longitude`
  String get longitude {
    return Intl.message(
      'longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `Allow Susanin to access your location?`
  String get permission_request {
    return Intl.message(
      'Allow Susanin to access your location?',
      name: 'permission_request',
      desc: '',
      args: [],
    );
  }

  /// `Deny`
  String get button_deny {
    return Intl.message(
      'Deny',
      name: 'button_deny',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get button_allow {
    return Intl.message(
      'Allow',
      name: 'button_allow',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get button_cancel {
    return Intl.message(
      'Cancel',
      name: 'button_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get button_save {
    return Intl.message(
      'Save',
      name: 'button_save',
      desc: '',
      args: [],
    );
  }

  /// `Poor compass accuracy: `
  String get low_compass_accuracy {
    return Intl.message(
      'Poor compass accuracy: ',
      name: 'low_compass_accuracy',
      desc: '',
      args: [],
    );
  }

  /// `Good compass accuracy: `
  String get normal_compass_accuracy {
    return Intl.message(
      'Good compass accuracy: ',
      name: 'normal_compass_accuracy',
      desc: '',
      args: [],
    );
  }

  /// `Move the phone several times in space as shown on the screen to calibrate compass.`
  String get compass_calibrate_instruction {
    return Intl.message(
      'Move the phone several times in space as shown on the screen to calibrate compass.',
      name: 'compass_calibrate_instruction',
      desc: '',
      args: [],
    );
  }

  /// `Hide`
  String get button_hide {
    return Intl.message(
      'Hide',
      name: 'button_hide',
      desc: '',
      args: [],
    );
  }

  /// ` `
  String get empty_locations_list_header {
    return Intl.message(
      ' ',
      name: 'empty_locations_list_header',
      desc: '',
      args: [],
    );
  }

  /// `No saved locations.\n\nAfter saving the current location, you can select it from the list and get it's direction and distance to it`
  String get empty_locations_list {
    return Intl.message(
      'No saved locations.\n\nAfter saving the current location, you can select it from the list and get it`s direction and distance to it',
      name: 'empty_locations_list',
      desc: '',
      args: [],
    );
  }

  /// `MM-dd-yyyy`
  String get date_format {
    return Intl.message(
      'MM-dd-yyyy',
      name: 'date_format',
      desc: '',
      args: [],
    );
  }

  /// `Delete location?`
  String get delete_location {
    return Intl.message(
      'Delete location?',
      name: 'delete_location',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get button_yes {
    return Intl.message(
      'Yes',
      name: 'button_yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get button_no {
    return Intl.message(
      'No',
      name: 'button_no',
      desc: '',
      args: [],
    );
  }

  /// `Distance to\nlocation: `
  String get no_compass_distance_to_point {
    return Intl.message(
      'Distance to\nlocation: ',
      name: 'no_compass_distance_to_point',
      desc: '',
      args: [],
    );
  }

  /// `Location\naccuracy: `
  String get no_compass_accuracy {
    return Intl.message(
      'Location\naccuracy: ',
      name: 'no_compass_accuracy',
      desc: '',
      args: [],
    );
  }

  /// `Compass not found`
  String get compass_not_found {
    return Intl.message(
      'Compass not found',
      name: 'compass_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Bad news`
  String get no_compass_bad_news_title {
    return Intl.message(
      'Bad news',
      name: 'no_compass_bad_news_title',
      desc: '',
      args: [],
    );
  }

  /// `Unfortunately, the application could not access the compass sensor, it may not be available in this device.`
  String get no_compass_bad_news_text {
    return Intl.message(
      'Unfortunately, the application could not access the compass sensor, it may not be available in this device.',
      name: 'no_compass_bad_news_text',
      desc: '',
      args: [],
    );
  }

  /// `Good news`
  String get no_compass_good_news_title {
    return Intl.message(
      'Good news',
      name: 'no_compass_good_news_title',
      desc: '',
      args: [],
    );
  }

  /// `Susanin still works, however, without indicating the direction. Will only show the distance to the target location.`
  String get no_compass_good_news_text {
    return Intl.message(
      'Susanin still works, however, without indicating the direction. Will only show the distance to the target location.',
      name: 'no_compass_good_news_text',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Instruction`
  String get button_instruction {
    return Intl.message(
      'Instruction',
      name: 'button_instruction',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get dark_theme {
    return Intl.message(
      'Dark theme',
      name: 'dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `Always on display`
  String get always_on_display {
    return Intl.message(
      'Always on display',
      name: 'always_on_display',
      desc: '',
      args: [],
    );
  }

  /// `Request permission`
  String get geolocation_permission {
    return Intl.message(
      'Request permission',
      name: 'geolocation_permission',
      desc: '',
      args: [],
    );
  }

  /// `Compass availability`
  String get has_compass {
    return Intl.message(
      'Compass availability',
      name: 'has_compass',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get button_next {
    return Intl.message(
      'Next',
      name: 'button_next',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get button_start {
    return Intl.message(
      'Start',
      name: 'button_start',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get tutorial_title_1 {
    return Intl.message(
      'Hello!',
      name: 'tutorial_title_1',
      desc: '',
      args: [],
    );
  }

  /// `I'll help you find the path to the saved location.\n\nNo maps or internet access required. Only permission to get your location and compass sensor in this device.\n\nOn the next screen, you can grant the necessary permissions.`
  String get tutorial_text_1 {
    return Intl.message(
      'I\'ll help you find the path to the saved location.\n\nNo maps or internet access required. Only permission to get your location and compass sensor in this device.\n\nOn the next screen, you can grant the necessary permissions.',
      name: 'tutorial_text_1',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get tutorial_title_2 {
    return Intl.message(
      'Settings',
      name: 'tutorial_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Follow Susanin!`
  String get tutorial_title_3 {
    return Intl.message(
      'Follow Susanin!',
      name: 'tutorial_title_3',
      desc: '',
      args: [],
    );
  }

  /// `If all necessary permissions is granted and the compass in the device is working correctly, the pointer shows the direct direction to Hollywood and the distance to it.\n\nNow you can save the location you are in to find your way back to it.`
  String get tutorial_text_3 {
    return Intl.message(
      'If all necessary permissions is granted and the compass in the device is working correctly, the pointer shows the direct direction to Hollywood and the distance to it.\n\nNow you can save the location you are in to find your way back to it.',
      name: 'tutorial_text_3',
      desc: '',
      args: [],
    );
  }

  /// `Acces to gelocation service is required.`
  String get tutorial_settings_permission {
    return Intl.message(
      'Acces to gelocation service is required.',
      name: 'tutorial_settings_permission',
      desc: '',
      args: [],
    );
  }

  /// `LOCATION SERVICE OFF\n\nPlease turn on the location service to continue.`
  String get tutorial_settings_disabled {
    return Intl.message(
      'LOCATION SERVICE OFF\n\nPlease turn on the location service to continue.',
      name: 'tutorial_settings_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Unfortunately, the application was not allowed to access the compass, so Susanin will not be able to indicate the direction to the target, it will only show the distance to target location.`
  String get tutorial_settings_no_compass {
    return Intl.message(
      'Unfortunately, the application was not allowed to access the compass, so Susanin will not be able to indicate the direction to the target, it will only show the distance to target location.',
      name: 'tutorial_settings_no_compass',
      desc: '',
      args: [],
    );
  }

  /// `Permission not granted.`
  String get error_geolocation_permission {
    return Intl.message(
      'Permission not granted.',
      name: 'error_geolocation_permission',
      desc: '',
      args: [],
    );
  }

  /// `Geolocation service disabled.`
  String get error_geolocation_disabled {
    return Intl.message(
      'Geolocation service disabled.',
      name: 'error_geolocation_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error_title {
    return Intl.message(
      'Error',
      name: 'error_title',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get error_unknown {
    return Intl.message(
      'Unknown error',
      name: 'error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `less than 5 m`
  String get less_than_5_m {
    return Intl.message(
      'less than 5 m',
      name: 'less_than_5_m',
      desc: '',
      args: [],
    );
  }

  /// `Permission not granted`
  String get error_geolocation_permission_short {
    return Intl.message(
      'Permission not granted',
      name: 'error_geolocation_permission_short',
      desc: '',
      args: [],
    );
  }

  /// `location name`
  String get location_name {
    return Intl.message(
      'location name',
      name: 'location_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter location name`
  String get enter_name {
    return Intl.message(
      'Please enter location name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect value`
  String get incorrect_value {
    return Intl.message(
      'Incorrect value',
      name: 'incorrect_value',
      desc: '',
      args: [],
    );
  }

  /// `{meters} m`
  String distance_meters(Object meters) {
    return Intl.message(
      '$meters m',
      name: 'distance_meters',
      desc: '',
      args: [meters],
    );
  }

  /// `{meters} km`
  String distance_kilometers(Object meters) {
    return Intl.message(
      '$meters km',
      name: 'distance_kilometers',
      desc: '',
      args: [meters],
    );
  }

  /// `If the direction pointer does not rotate when you move your phone, you need to enable compass calibration:\nSettings -> Privacy -> Location Services -> System Services -> Compass Calibration.`
  String get ios_compass_settings_info {
    return Intl.message(
      'If the direction pointer does not rotate when you move your phone, you need to enable compass calibration:\nSettings -> Privacy -> Location Services -> System Services -> Compass Calibration.',
      name: 'ios_compass_settings_info',
      desc: '',
      args: [],
    );
  }

  /// `Display auto turn off disabled`
  String get always_on_display_on {
    return Intl.message(
      'Display auto turn off disabled',
      name: 'always_on_display_on',
      desc: '',
      args: [],
    );
  }

  /// `Display auto turn off enabled`
  String get always_on_display_off {
    return Intl.message(
      'Display auto turn off enabled',
      name: 'always_on_display_off',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get copied {
    return Intl.message(
      'Copied',
      name: 'copied',
      desc: '',
      args: [],
    );
  }

  /// `notes`
  String get notes {
    return Intl.message(
      'notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
