import 'package:get/get.dart';

class SpokenLanguageModal {
  String? langugaeName;
  String? languageCode;
  int? id;
  RxBool isSelected;

  SpokenLanguageModal({
    required this.languageCode,
    required this.langugaeName,
    required this.id,
    required this.isSelected,
  });
}
