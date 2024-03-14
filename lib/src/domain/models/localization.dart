class Localization {
  final int id;
  final String locale;

  Localization(this.id, this.locale);

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
      json['id'],
      json['locale'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'locale': locale,
    };
  }
}

// Table name
const String localizationTableName = "localization";

// Column names
const String localizationColumnId = "id";
const String localizationColumnLocale = "locale";
