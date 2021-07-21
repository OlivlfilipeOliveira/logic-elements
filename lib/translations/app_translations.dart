
import 'package:logic_elements_pibic/translations/en_US/en_us_translation.dart';
import 'package:logic_elements_pibic/translations/pt_BR/pt_br_translation.dart';

abstract class AppTranslation{

  static Map<String, Map<String, String>> translations = {
    'pt_BR': ptBr,
    'en_US': enUs
  };
}