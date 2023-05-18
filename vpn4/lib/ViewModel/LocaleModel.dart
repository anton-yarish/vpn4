import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Supported languages
// ignore: constant_identifier_names
enum Language { English, Hindi, Bangladeshi, Japanese, Portuguese, Spanish }

class LocalizationProvider with ChangeNotifier {
  Locale? _locale; // Current locale
  Language? _selectedLanguage; // Currently selected language

  // Constructor
  LocalizationProvider() {
    // Initialize with the stored language, or default to English

    _loadSavedLanguage();
  }

  // Load the saved language from shared_preferences
  void _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('language');
    if (lang != null) {
      // Set the selected language based on the stored language
      _selectedLanguage = Language.values[int.parse(lang)];
      _locale = _getLocaleFromLanguage(_selectedLanguage!);
      print(
          "The saved language is ${locale} and the selected language is ${_selectedLanguage}");
      notifyListeners();
    }
  }

  // Get the locale from the selected language
  Locale _getLocaleFromLanguage(Language language) {
    switch (language) {
      case Language.English:
        return const Locale('en', '');
      case Language.Spanish:
        return const Locale('es', '');
      case Language.Bangladeshi:
        return const Locale("bn", "");
      case Language.Japanese:
        return const Locale('ja', '');
      case Language.Hindi:
        return const Locale('hi', '');
      case Language.Portuguese:
        return const Locale("pt", "");

      default:
        return const Locale('en', '');
    }
  }

  // Get the currently selected language
  Language get selectedLanguage => _selectedLanguage!;

  // Get the current locale
  Locale get locale => _locale!;

  // Set the selected language and save it in shared_preferences
  void setSelectedLanguage(Language language) async {
    _selectedLanguage = language;
    _locale = _getLocaleFromLanguage(language);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _selectedLanguage!.index.toString());
    notifyListeners();
  }
}
