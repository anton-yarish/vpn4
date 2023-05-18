// ignore: file_names
class LanguageModel {
  final int id;
  final String name;
  final String code;
  final String flag;

  LanguageModel(this.id, this.name, this.code, this.flag);

  static List<LanguageModel> languageList = [
    LanguageModel(0, "English", "en", "🇺🇸"),
    LanguageModel(1, "हिंदी", "hi", "🇮🇳"),
    LanguageModel(2, "বাংলা", "bn", "🇧🇩"),
    LanguageModel(3, "日本", "jp", "🇯🇵"),
    LanguageModel(4, "português", "pt", "🇵🇹"),
    LanguageModel(5, "Española", "es", "🇪🇸"),
  ];
}
