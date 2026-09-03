import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/preference_keys.dart';

const defaultAppLocale = Locale('id');

abstract interface class LocalePreferences {
  Future<Locale?> load();
  Future<void> save(Locale locale);
}

final localePreferencesProvider = Provider<LocalePreferences>(
  (ref) => SharedPreferencesLocalePreferences(SharedPreferencesAsync()),
);

final localeControllerProvider = NotifierProvider<LocaleController, Locale>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale> {
  var _restoreScheduled = false;

  @override
  Locale build() {
    if (!_restoreScheduled) {
      _restoreScheduled = true;
      Future<void>.microtask(restore);
    }
    return defaultAppLocale;
  }

  Future<void> restore() async {
    try {
      final savedLocale = await ref.read(localePreferencesProvider).load();
      if (savedLocale != null) {
        state = savedLocale;
      }
    } catch (_) {
      // A missing preference service must not prevent offline app startup.
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await ref.read(localePreferencesProvider).save(locale);
  }
}

class SharedPreferencesLocalePreferences implements LocalePreferences {
  SharedPreferencesLocalePreferences(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<Locale?> load() async {
    final languageCode = await _preferences.getString(PreferenceKeys.locale);
    if (languageCode == 'id' || languageCode == 'en') {
      return Locale(languageCode!);
    }
    return null;
  }

  @override
  Future<void> save(Locale locale) =>
      _preferences.setString(PreferenceKeys.locale, locale.languageCode);
}
