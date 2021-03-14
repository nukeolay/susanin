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

  /// `Susanin can't get access to compass sensor`
  String get locationNoCompass {
    return Intl.message(
      'Susanin can\'t get access to compass sensor',
      name: 'locationNoCompass',
      desc: '',
      args: [],
    );
  }

  /// `Press `
  String get locationEmptyList1 {
    return Intl.message(
      'Press ',
      name: 'locationEmptyList1',
      desc: '',
      args: [],
    );
  }

  /// `"Add location"`
  String get locationEmptyList2 {
    return Intl.message(
      '"Add location"',
      name: 'locationEmptyList2',
      desc: '',
      args: [],
    );
  }

  /// ` button to save current location\n\nAfter saving the current location, you can select it from the list and see it's direction and distance to it`
  String get locationEmptyList3 {
    return Intl.message(
      ' button to save current location\n\nAfter saving the current location, you can select it from the list and see it`s direction and distance to it',
      name: 'locationEmptyList3',
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

  /// `SKIP`
  String get onBoardingButtonSkip {
    return Intl.message(
      'SKIP',
      name: 'onBoardingButtonSkip',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get onBoardingButtonNext {
    return Intl.message(
      'NEXT',
      name: 'onBoardingButtonNext',
      desc: '',
      args: [],
    );
  }

  /// `GET STARTED NOW`
  String get onBoardingButtonStart {
    return Intl.message(
      'GET STARTED NOW',
      name: 'onBoardingButtonStart',
      desc: '',
      args: [],
    );
  }

  /// `How to save locations`
  String get onBoardingTitle1 {
    return Intl.message(
      'How to save locations',
      name: 'onBoardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `assets/instr_1_en.png`
  String get onBoardingImage1 {
    return Intl.message(
      'assets/instr_1_en.png',
      name: 'onBoardingImage1',
      desc: '',
      args: [],
    );
  }

  /// `Simply press round button in the right bottom corner of the screen to save current location`
  String get onBoardingInstruction1 {
    return Intl.message(
      'Simply press round button in the right bottom corner of the screen to save current location',
      name: 'onBoardingInstruction1',
      desc: '',
      args: [],
    );
  }

  /// `How to use Susanin`
  String get onBoardingTitle2 {
    return Intl.message(
      'How to use Susanin',
      name: 'onBoardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `assets/instr_2_en.png`
  String get onBoardingImage2 {
    return Intl.message(
      'assets/instr_2_en.png',
      name: 'onBoardingImage2',
      desc: '',
      args: [],
    );
  }

  /// `The large pointer shows straight direction to the saved location and the large number shows distance to it. The small pointer in the right section of the screen is compass, it always shows to the North and the number under it is the current GPS accuracy`
  String get onBoardingInstruction2 {
    return Intl.message(
      'The large pointer shows straight direction to the saved location and the large number shows distance to it. The small pointer in the right section of the screen is compass, it always shows to the North and the number under it is the current GPS accuracy',
      name: 'onBoardingInstruction2',
      desc: '',
      args: [],
    );
  }

  /// `How to edit\nsaved locations`
  String get onBoardingTitle3 {
    return Intl.message(
      'How to edit\nsaved locations',
      name: 'onBoardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `assets/instr_3_en.png`
  String get onBoardingImage3 {
    return Intl.message(
      'assets/instr_3_en.png',
      name: 'onBoardingImage3',
      desc: '',
      args: [],
    );
  }

  /// `If you want to change the name of saved location on share it with your friend simply swipe it to the left and press one of two buttons\nIf you want to delete saved location swipe it to the right and press Delete`
  String get onBoardingInstruction3 {
    return Intl.message(
      'If you want to change the name of saved location on share it with your friend simply swipe it to the left and press one of two buttons\nIf you want to delete saved location swipe it to the right and press Delete',
      name: 'onBoardingInstruction3',
      desc: '',
      args: [],
    );
  }

  /// `How to switch\nLight/Dark mode`
  String get onBoardingTitle4 {
    return Intl.message(
      'How to switch\nLight/Dark mode',
      name: 'onBoardingTitle4',
      desc: '',
      args: [],
    );
  }

  /// `assets/instr_4_en.png`
  String get onBoardingImage4 {
    return Intl.message(
      'assets/instr_4_en.png',
      name: 'onBoardingImage4',
      desc: '',
      args: [],
    );
  }

  /// `Simply swipe tile with large pointer to the left and press button`
  String get onBoardingInstruction4 {
    return Intl.message(
      'Simply swipe tile with large pointer to the left and press button',
      name: 'onBoardingInstruction4',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
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