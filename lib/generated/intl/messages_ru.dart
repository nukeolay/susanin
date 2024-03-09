// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(meters) => "${meters} км";

  static String m1(meters) => "${meters} м";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accuracy_details": MessageLookupByLibrary.simpleMessage(
            "точность определения геолокации: "),
        "always_on_display":
            MessageLookupByLibrary.simpleMessage("Экран всегда включен"),
        "always_on_display_off": MessageLookupByLibrary.simpleMessage(
            "Автоматическое выключение дисплея включено"),
        "always_on_display_on": MessageLookupByLibrary.simpleMessage(
            "Автоматическое выключение дисплея отключено"),
        "button_allow": MessageLookupByLibrary.simpleMessage("Разрешить"),
        "button_back_to_locations":
            MessageLookupByLibrary.simpleMessage("К выбору локаций"),
        "button_cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "button_deny": MessageLookupByLibrary.simpleMessage("Запретить"),
        "button_hide": MessageLookupByLibrary.simpleMessage("Свернуть"),
        "button_instruction":
            MessageLookupByLibrary.simpleMessage("Посмотреть инструкцию"),
        "button_next": MessageLookupByLibrary.simpleMessage("Далее"),
        "button_no": MessageLookupByLibrary.simpleMessage("Нет"),
        "button_save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "button_start": MessageLookupByLibrary.simpleMessage("Начать"),
        "button_yes": MessageLookupByLibrary.simpleMessage("Да"),
        "compass_calibrate_instruction": MessageLookupByLibrary.simpleMessage(
            "Чтобы увеличить точность компаса, несколько раз переместите телефон в пространстве как указано выше."),
        "compass_not_found":
            MessageLookupByLibrary.simpleMessage("Компас не обнаружен"),
        "copied": MessageLookupByLibrary.simpleMessage("Скопировано"),
        "current_location":
            MessageLookupByLibrary.simpleMessage("текущее местоположение"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Темная тема"),
        "date_format": MessageLookupByLibrary.simpleMessage("dd-MM-yyyy"),
        "delete_location":
            MessageLookupByLibrary.simpleMessage("Удалить локацию?"),
        "distance_kilometers": m0,
        "distance_meters": m1,
        "empty_locations_list": MessageLookupByLibrary.simpleMessage(
            "Нет сохраненных локаций.\n\nСохраните локацию, после этого Вы сможете в любой момент в любом месте выбрать ее из списка и увидеть в каком направлении и на каком расстоянии от Вас она находится."),
        "empty_locations_list_header":
            MessageLookupByLibrary.simpleMessage(" "),
        "enter_name": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите название"),
        "error_geolocation_disabled":
            MessageLookupByLibrary.simpleMessage("Cервис геолокации выключен"),
        "error_geolocation_permission": MessageLookupByLibrary.simpleMessage(
            "Отсутствует доступ к сервису геолокации."),
        "error_geolocation_permission_short":
            MessageLookupByLibrary.simpleMessage("Разрешение не выдано"),
        "error_title": MessageLookupByLibrary.simpleMessage("Ошибка"),
        "error_unknown":
            MessageLookupByLibrary.simpleMessage("Неизвестный сбой"),
        "geolocation_permission":
            MessageLookupByLibrary.simpleMessage("Доступ к геолокации"),
        "has_compass": MessageLookupByLibrary.simpleMessage(
            "Наличие компаса в устройстве"),
        "incorrect_value":
            MessageLookupByLibrary.simpleMessage("Некорректное значение"),
        "ios_compass_settings_info": MessageLookupByLibrary.simpleMessage(
            "Если указатель компаса не вращается при перемещении телефона, необходимо включить калибровку компаса:\nНастройки -> Конфиденциальность -> Службы геолокации -> Системные службы -> Калибровка компаса."),
        "latitude": MessageLookupByLibrary.simpleMessage("широта"),
        "less_than_5_m": MessageLookupByLibrary.simpleMessage("менее 5 м"),
        "location_name":
            MessageLookupByLibrary.simpleMessage("название локации"),
        "longitude": MessageLookupByLibrary.simpleMessage("долгота"),
        "low_compass_accuracy":
            MessageLookupByLibrary.simpleMessage("Низкая точность компаса: "),
        "no_compass_accuracy": MessageLookupByLibrary.simpleMessage(
            "Точность определения\nгеолокации: "),
        "no_compass_bad_news_text": MessageLookupByLibrary.simpleMessage(
            "К сожалению, приложение не смогло получить доступ к датчику компаса, возможно он отсутствует в данном устройстве."),
        "no_compass_bad_news_title":
            MessageLookupByLibrary.simpleMessage("Плохие новости"),
        "no_compass_distance_to_point":
            MessageLookupByLibrary.simpleMessage("Расстояние\nдо цели: "),
        "no_compass_good_news_text": MessageLookupByLibrary.simpleMessage(
            "Сусанин все равно работает, правда, без указания направления. Будет показывать только расстояние до сохраненной локации."),
        "no_compass_good_news_title":
            MessageLookupByLibrary.simpleMessage("Хорошие новости"),
        "normal_compass_accuracy":
            MessageLookupByLibrary.simpleMessage("Точность компаса высокая: "),
        "permission_request": MessageLookupByLibrary.simpleMessage(
            "Разрешить приложению доступ к определению геолокации?"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "title": MessageLookupByLibrary.simpleMessage("Susanin"),
        "tutorial_settings_disabled": MessageLookupByLibrary.simpleMessage(
            "СЕРВИС ГЕОЛОКАЦИИ ВЫКЛЮЧЕН\n\nПожалуйста включите сервис геолокации, чтобы продолжить."),
        "tutorial_settings_no_compass": MessageLookupByLibrary.simpleMessage(
            "К сожалению приложению не далось получить доступ к компасу, поэтому Сусанин не сможет указывать направление к цели, а будет показывать только расстояние до нее."),
        "tutorial_settings_permission": MessageLookupByLibrary.simpleMessage(
            "Для корректной работы приложения необходимо разрешение на определение геолокации."),
        "tutorial_text_1": MessageLookupByLibrary.simpleMessage(
            "Я помогу тебе найти путь к сохраненной локации.\n\nНикаких карт и доступа к интернету не потребуется. Только разрешение на определение геолокации и наличие компаса в телефоне.\n\nНа следующем экране ты сможешь выдать необходимые разрешения."),
        "tutorial_text_3": MessageLookupByLibrary.simpleMessage(
            "Если разрешение на доступ к геолокации выдано и компас в устройстве работает правильно, то указатель показывает прямое направление до Голливуда и расстояние до него.\n\nТеперь ты сможешь сохранять локацию на которой  находишься, чтобы найти обратный путь к ней."),
        "tutorial_title_1": MessageLookupByLibrary.simpleMessage("Привет!"),
        "tutorial_title_2": MessageLookupByLibrary.simpleMessage("Настройки"),
        "tutorial_title_3":
            MessageLookupByLibrary.simpleMessage("Вперед за Сусаниным!")
      };
}
