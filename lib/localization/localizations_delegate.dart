import 'package:get/get.dart';

import 'languages/language_ar.dart';

import 'languages/language_en.dart';


class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "en_US": enUS,
    "ar_SA": arSA,
  };
}

final List<LanguageModel> languages = [
  LanguageModel("🇸🇦", "(عربى) Arabic", 'ar', 'SA'),
  LanguageModel("🇺🇸", "English (English)", 'en', 'US'),
];

class LanguageModel {
  LanguageModel(
      this.symbol,
      this.language,
      this.languageCode,
      this.countryCode,
      );

  String language;
  String symbol;
  String countryCode;
  String languageCode;
}
