// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
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
  String get localeName => 'uk';

  static String m0(meters) => "${meters} км";

  static String m1(meters) => "${meters} м";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accuracy_details": MessageLookupByLibrary.simpleMessage(
            "точність визначення геолокації: "),
        "always_on_display":
            MessageLookupByLibrary.simpleMessage("Екран завжди увімкнений"),
        "always_on_display_off": MessageLookupByLibrary.simpleMessage(
            "Автоматичне вимикання дисплея увімкнено"),
        "always_on_display_on": MessageLookupByLibrary.simpleMessage(
            "Автоматичне вимкнення дисплея вимкнено"),
        "button_allow": MessageLookupByLibrary.simpleMessage("Дозволити"),
        "button_back_to_locations":
            MessageLookupByLibrary.simpleMessage("До вибору локацій"),
        "button_cancel": MessageLookupByLibrary.simpleMessage("Скасування"),
        "button_deny": MessageLookupByLibrary.simpleMessage("Заборонити"),
        "button_edit_location":
            MessageLookupByLibrary.simpleMessage("Редагувати"),
        "button_hide": MessageLookupByLibrary.simpleMessage("Згорнути"),
        "button_instruction":
            MessageLookupByLibrary.simpleMessage("Переглянути інструкцію"),
        "button_next": MessageLookupByLibrary.simpleMessage("Далі"),
        "button_no": MessageLookupByLibrary.simpleMessage("Ні"),
        "button_save": MessageLookupByLibrary.simpleMessage("Зберегти"),
        "button_select": MessageLookupByLibrary.simpleMessage("Вибрати"),
        "button_start": MessageLookupByLibrary.simpleMessage("Почати"),
        "button_yes": MessageLookupByLibrary.simpleMessage("Так"),
        "compass_calibrate_instruction": MessageLookupByLibrary.simpleMessage(
            "Щоб збільшити точність компаса, кілька разів перемістіть телефон у просторі, як зазначено вище."),
        "compass_not_found":
            MessageLookupByLibrary.simpleMessage("Компас не виявлено"),
        "copied": MessageLookupByLibrary.simpleMessage("Скопійовано"),
        "current_location":
            MessageLookupByLibrary.simpleMessage("поточне розташування"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Темна тема"),
        "date_format": MessageLookupByLibrary.simpleMessage("dd-MM-yyyy"),
        "delete_location":
            MessageLookupByLibrary.simpleMessage("Видалити локацію?"),
        "distance_kilometers": m0,
        "distance_meters": m1,
        "empty_locations_list": MessageLookupByLibrary.simpleMessage(
            "Немає збережених локацій.\n\nЗбережіть локацію, після цього Ви зможете у будь-який момент у будь-якому місці вибрати її зі списку та побачити у якому напрямку та на якій відстані від Вас вона знаходиться."),
        "empty_locations_list_header":
            MessageLookupByLibrary.simpleMessage(" "),
        "enter_name":
            MessageLookupByLibrary.simpleMessage("Будь ласка, введіть назву"),
        "error_geolocation_disabled":
            MessageLookupByLibrary.simpleMessage("Сервіс геолокації вимкнено"),
        "error_geolocation_permission": MessageLookupByLibrary.simpleMessage(
            "Немає доступу до сервісу геолокації."),
        "error_geolocation_permission_short":
            MessageLookupByLibrary.simpleMessage("Дозвіл не видано"),
        "error_title": MessageLookupByLibrary.simpleMessage("Помилка"),
        "error_unknown": MessageLookupByLibrary.simpleMessage("Невідомий збій"),
        "geolocation_permission":
            MessageLookupByLibrary.simpleMessage("Доступ до геолокації"),
        "has_compass": MessageLookupByLibrary.simpleMessage(
            "Наявність компаса у пристрої"),
        "incorrect_value":
            MessageLookupByLibrary.simpleMessage("Некоректне значення"),
        "ios_compass_settings_info": MessageLookupByLibrary.simpleMessage(
            "Якщо вказівник компаса не обертається під час переміщення телефону, необхідно ввімкнути калібрування компаса:\nНалаштування -> Конфіденційність -> Служби геолокації -> Системні служби -> Калібрування компаса."),
        "latitude": MessageLookupByLibrary.simpleMessage("широта"),
        "less_than_5_m": MessageLookupByLibrary.simpleMessage("менше 5 м"),
        "location_default_name":
            MessageLookupByLibrary.simpleMessage("локація"),
        "location_name": MessageLookupByLibrary.simpleMessage("назва локації"),
        "longitude": MessageLookupByLibrary.simpleMessage("довгота"),
        "low_compass_accuracy":
            MessageLookupByLibrary.simpleMessage("Низька точність компасу: "),
        "no_compass_accuracy": MessageLookupByLibrary.simpleMessage(
            "Точність визначення\nгеолокації: "),
        "no_compass_bad_news_text": MessageLookupByLibrary.simpleMessage(
            "На жаль, програма не змогла отримати доступ до датчика компаса, можливо, він відсутній у цьому пристрої."),
        "no_compass_bad_news_title":
            MessageLookupByLibrary.simpleMessage("Погані новини"),
        "no_compass_distance_to_point":
            MessageLookupByLibrary.simpleMessage("Відстань\nдо мети: "),
        "no_compass_good_news_text": MessageLookupByLibrary.simpleMessage(
            "Сусанін все одно працює, щоправда, без зазначення напряму. Відображатиме лише відстань до збереженої локації."),
        "no_compass_good_news_title":
            MessageLookupByLibrary.simpleMessage("Гарні новини"),
        "normal_compass_accuracy":
            MessageLookupByLibrary.simpleMessage("Точность компаса высокая: "),
        "notes": MessageLookupByLibrary.simpleMessage("нотатки"),
        "permission_request": MessageLookupByLibrary.simpleMessage(
            "Дозволити застосунку доступ до визначення геолокації?"),
        "settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
        "title": MessageLookupByLibrary.simpleMessage("Susanin"),
        "tutorial_settings_disabled": MessageLookupByLibrary.simpleMessage(
            "СЕРВІС ГЕОЛОКАЦІЇ ВИКЛЮЧЕНО\n\nБудь ласка, увімкніть сервіс геолокації, щоб продовжити."),
        "tutorial_settings_no_compass": MessageLookupByLibrary.simpleMessage(
            "На жаль додатку не далося отримати доступ до компасу, тому Сусанін не зможе вказувати напрямок до мети, а показуватиме лише відстань до неї."),
        "tutorial_settings_permission": MessageLookupByLibrary.simpleMessage(
            "Для коректної роботи програми потрібний дозвіл на визначення геолокації."),
        "tutorial_text_1": MessageLookupByLibrary.simpleMessage(
            "Я допоможу тобі знайти шлях до збереженої локації.\n\nЖодних карт та доступу до інтернету не потрібно. Тільки дозвіл на визначення геолокації та наявність компаса в телефоні. На наступному екрані ти зможеш видати необхідні дозволи."),
        "tutorial_text_3": MessageLookupByLibrary.simpleMessage(
            "Якщо дозвіл на доступ до геолокації видано і компас у пристрої працює правильно, то покажчик показує прямий напрямок до Голлівуду та відстань до нього.\n\nТепер ти зможеш зберігати локацію на якій знаходишся, щоб знайти зворотний шлях до неї."),
        "tutorial_title_1": MessageLookupByLibrary.simpleMessage("Вітання!"),
        "tutorial_title_2":
            MessageLookupByLibrary.simpleMessage("Налаштування"),
        "tutorial_title_3":
            MessageLookupByLibrary.simpleMessage("Вперед за Сусаніним!")
      };
}
