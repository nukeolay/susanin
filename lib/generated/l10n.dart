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

  /// `Cancel`
  String get buttonCancel {
    return Intl.message(
      'Cancel',
      name: 'buttonCancel',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get buttonRename {
    return Intl.message(
      'Rename',
      name: 'buttonRename',
      desc: '',
      args: [],
    );
  }

  /// `Request permission`
  String get buttonRequestPermission {
    return Intl.message(
      'Request permission',
      name: 'buttonRequestPermission',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get buttonDelete {
    return Intl.message(
      'Delete',
      name: 'buttonDelete',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get buttonShare {
    return Intl.message(
      'Share',
      name: 'buttonShare',
      desc: '',
      args: [],
    );
  }

  /// `Service Disabled`
  String get serviceDisabled {
    return Intl.message(
      'Service Disabled',
      name: 'serviceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Checking permission`
  String get checkingPermission {
    return Intl.message(
      'Checking permission',
      name: 'checkingPermission',
      desc: '',
      args: [],
    );
  }

  /// `Permission Denied`
  String get permissionDenied {
    return Intl.message(
      'Permission Denied',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `No compass detected`
  String get noCompass {
    return Intl.message(
      'No compass detected',
      name: 'noCompass',
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

  /// `Location service disabled, please turn on location service`
  String get locationServiceDisabled {
    return Intl.message(
      'Location service disabled, please turn on location service',
      name: 'locationServiceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Trying to get access to location service.\nIf you see this message longer than 10 sec, press button\n`
  String get locationPermissionDenied {
    return Intl.message(
      'Trying to get access to location service.\nIf you see this message longer than 10 sec, press button\n',
      name: 'locationPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Susanin does not have access to location service`
  String get locationPermissionDeniedForever {
    return Intl.message(
      'Susanin does not have access to location service',
      name: 'locationPermissionDeniedForever',
      desc: '',
      args: [],
    );
  }

  /// `Press "Add location" button to save current location\n\nAfter saving the current location, you can select it from the list and see it's direction and distance to it`
  String get locationEmptyList {
    return Intl.message(
      'Press "Add location" button to save current location\n\nAfter saving the current location, you can select it from the list and see it`s direction and distance to it',
      name: 'locationEmptyList',
      desc: '',
      args: [],
    );
  }

  /// `No saved locations`
  String get noSavedLocations {
    return Intl.message(
      'No saved locations',
      name: 'noSavedLocations',
      desc: '',
      args: [],
    );
  }

  /// `Less than 5 m`
  String get lessThan5Metres {
    return Intl.message(
      'Less than 5 m',
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

  /// `MM/dd/yyyy H:mm`
  String get dateFormat {
    return Intl.message(
      'MM/dd/yyyy H:mm',
      name: 'dateFormat',
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