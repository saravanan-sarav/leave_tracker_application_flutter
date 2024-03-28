class Localization {
  final int id;
  final String locale;
  final String language;

  Localization(this.id, this.locale, this.language);

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(json['id'], json['locale'], json['language']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'locale': locale, 'language': language};
  }
}

// Table name
const String localizationTableName = "localization";

// Column names
const String localizationColumnId = "id";
const String localizationColumnLocale = "locale";
const String localizationColumnLanguage = "language";
