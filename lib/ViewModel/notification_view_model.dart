import 'dart:developer';

import 'package:get/get.dart';

class NotificationViewModel extends GetxController {
  String searchText = '';

  List<Map<String, dynamic>> name = [
    {'name': 'DARSHAK'},
    {'name': 'BHARAT'},
    {'name': 'KOMAL'},
    {'name': 'DHARMESH'},
  ];
  bool selectAll = false;

  updateSelectAll() {
    selectAll = !selectAll;
    if (selectAll == true) {
      name.forEach((element) {
        element['value'] = true;
      });
    } else {
      name.forEach((element) {
        element['value'] = false;
      });
    }
    update();
  }

  var holder_1 = [];

  updateSearch(value) {
    searchText = value;
    update();
  }

  addValue() {
    for (int i = 0; i < name.length; i++) {
      name[i].addAll({'value': false});
    }
  }

  updateValue(value, index) {
    name[index]['value'] = value;
    List values = [];

    name.forEach((element) {
      values.add(element['value'].toString());
      log('------values-----$values');
      if (values.contains('false')) {
        selectAll = false;
        update();
      } else {
        selectAll = true;
        update();
      }
    });
    update();
  }

  getItems() {
    name.forEach((element) {
      if (element['value'] == true) {
        holder_1.add(element['name']);
      }
    });
    log('------holder_1-----$holder_1');
    holder_1.clear();
  }

  @override
  void onInit() {
    addValue();
    super.onInit();
  }
}
