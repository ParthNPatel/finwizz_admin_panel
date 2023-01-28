import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/get_movers_repo.dart';
import 'package:finwizz_admin/Model/Repo/get_user_stock.dart';
import 'package:get/get.dart';

class GetUserStockViewModel extends GetxController {
  dynamic stockUserData;
  var holder_1 = [];
  String searchText = '';
  bool selectAll = false;
  bool loading = false;

  updateLoadingValue(val) {
    loading = val;
    update();
  }

  ApiResponse _getUserStockApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getUserStockApiResponse => _getUserStockApiResponse;

  Future<void> getUserStockViewModel({bool isLoading = true}) async {
    updateLoadingValue(true);
    if (isLoading) {
      _getUserStockApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      stockUserData = await GetStockUserRepo().getStockUserRepo();

      print("stockUserData=response==>$stockUserData");
      _getUserStockApiResponse = ApiResponse.complete(stockUserData);

      for (int i = 0; i < stockUserData['data']['docs'].length; i++) {
        stockUserData['data']['docs'][i].addAll({'value': false});
      }
      updateLoadingValue(false);
    } catch (e) {
      print("stockUserData=e==>$e");
      updateLoadingValue(false);

      _getUserStockApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// FOR NOTIFICATION

  updateSelectAll(value) {
    selectAll = value;
    if (selectAll == true) {
      stockUserData['data']['docs'].forEach((element) {
        element['value'] = true;
      });
    } else {
      stockUserData['data']['docs'].forEach((element) {
        element['value'] = false;
      });
    }
    update();
  }

  updateSearch(value) {
    searchText = value;
    update();
  }

  updateValue(value, index) {
    stockUserData['data']['docs'][index]['value'] = value;
    List values = [];

    stockUserData['data']['docs'].forEach((element) {
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
    holder_1.clear();
    stockUserData['data']['docs'].forEach((element) {
      if (element['value'] == true) {
        holder_1.add(element['_id']);
      }
    });
    log('------holder_1-----$holder_1');

    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
