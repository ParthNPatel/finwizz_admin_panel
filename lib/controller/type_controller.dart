import 'package:get/get.dart';

class TypeController extends GetxController {
  var type = ['Positive', 'Negative', 'Neutral'].obs;
  var selectedType = 'Positive'.obs;

  updateSelectedType(String value) {
    selectedType.value = value;
  }

  var typeCompany = ['Tesla', 'Ferrari', 'Bugatti'].obs;
  var selectedCompanyType = 'Tesla'.obs;

  updateSelectedCompanyType(String value) {
    selectedCompanyType.value = value;
  }
}
