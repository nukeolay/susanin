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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Delete location?`
  String get deleteLocation {
    return Intl.message(
      'Delete location?',
      name: 'deleteLocation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Dark/Light mode`
  String get changeTheme {
    return Intl.message(
      'Dark/Light mode',
      name: 'changeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Save location & find your way back (works offline, no network connection needed)`
  String get infoContent {
    return Intl.message(
      'Save location & find your way back (works offline, no network connection needed)',
      name: 'infoContent',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Enter location name`
  String get renameLocationTitle {
    return Intl.message(
      'Enter location name',
      name: 'renameLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `New location №`
  String get locationNameTemplate {
    return Intl.message(
      'New location №',
      name: 'locationNameTemplate',
      desc: '',
      args: [],
    );
  }

  /// `Add current location`
  String get addCurrentLocation {
    return Intl.message(
      'Add current location',
      name: 'addCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location service is disabled`
  String get warningLocationServiceDisabled {
    return Intl.message(
      'Location service is disabled',
      name: 'warningLocationServiceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Please turn on location service`
  String get warningTurnOnLocationService {
    return Intl.message(
      'Please turn on location service',
      name: 'warningTurnOnLocationService',
      desc: '',
      args: [],
    );
  }

  /// `No saved locations.`
  String get warningNoSavedLocations {
    return Intl.message(
      'No saved locations.',
      name: 'warningNoSavedLocations',
      desc: '',
      args: [],
    );
  }

  /// `Please press `
  String get warningPleasePress {
    return Intl.message(
      'Please press ',
      name: 'warningPleasePress',
      desc: '',
      args: [],
    );
  }

  /// ` to save current location.`
  String get warningToSaveLocation {
    return Intl.message(
      ' to save current location.',
      name: 'warningToSaveLocation',
      desc: '',
      args: [],
    );
  }

  /// `After saving the current location, you can select it from the list and see it's direction and distance to it. Also, you can share it with your friends.`
  String get warningInstruction {
    return Intl.message(
      'After saving the current location, you can select it from the list and see it`s direction and distance to it. Also, you can share it with your friends.',
      name: 'warningInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Location permission denied`
  String get warningGPSPermissionDenied {
    return Intl.message(
      'Location permission denied',
      name: 'warningGPSPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Request permission`
  String get warningRequestGPSPermission {
    return Intl.message(
      'Request permission',
      name: 'warningRequestGPSPermission',
      desc: '',
      args: [],
    );
  }

  /// `Distance is less than 5 m`
  String get lessThan5Metres {
    return Intl.message(
      'Distance is less than 5 m',
      name: 'lessThan5Metres',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get metres {
    return Intl.message(
      'm',
      name: 'metres',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get kilometres {
    return Intl.message(
      'km',
      name: 'kilometres',
      desc: '',
      args: [],
    );
  }

  /// `minicompass`
  String get tipCompass {
    return Intl.message(
      'minicompass',
      name: 'tipCompass',
      desc: '',
      args: [],
    );
  }

  /// `GPS accuracy`
  String get tipLocationAccuracy {
    return Intl.message(
      'GPS accuracy',
      name: 'tipLocationAccuracy',
      desc: '',
      args: [],
    );
  }

  /// `accuracy`
  String get locationAccuracy {
    return Intl.message(
      'accuracy',
      name: 'locationAccuracy',
      desc: '',
      args: [],
    );
  }

  /// `compass`
  String get compass {
    return Intl.message(
      'compass',
      name: 'compass',
      desc: '',
      args: [],
    );
  }

  /// `Delete location`
  String get tipDeleteLocation {
    return Intl.message(
      'Delete location',
      name: 'tipDeleteLocation',
      desc: '',
      args: [],
    );
  }

  /// `Share location`
  String get tipShareLocation {
    return Intl.message(
      'Share location',
      name: 'tipShareLocation',
      desc: '',
      args: [],
    );
  }

  /// `MM/dd/yyyy H:mm`
  String get dateFormat {
    return Intl.message(
      'MM/dd/yyyy H:mm',
      name: 'dateFormat',
      desc: '',
      args: [],
    );
  }

  /// `Rename location`
  String get tipRenameLocation {
    return Intl.message(
      'Rename location',
      name: 'tipRenameLocation',
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
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}