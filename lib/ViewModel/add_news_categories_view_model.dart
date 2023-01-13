import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/add_news__categories_repo.dart';
import 'package:finwizz_admin/Model/Response_model/add_news_categories_res_model.dart';
import 'package:get/get.dart';

class AddNewsCategoriesViewModel extends GetxController {
  bool loader = false;

  updateLoader(val) {
    loader = val;
    update();
  }

  ApiResponse _addNewsCategoriesApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addNewsCategoriesApiResponse => _addNewsCategoriesApiResponse;

  Future<void> addNewsCategoriesViewModel(
      {bool isLoading = true, Map<String, dynamic>? model}) async {
    updateLoader(true);
    if (isLoading) {
      _addNewsCategoriesApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      AddNewsCategoriesResponseModel response =
          await AddNewsCategoriesRepo().addNewsCategoriesRepo(body: model);
      // log("AddNewsCategoriesResponseModel=response==>$response");

      _addNewsCategoriesApiResponse = ApiResponse.complete(response);
      updateLoader(false);
    } catch (e) {
      log("AddNewsCategoriesResponseModel=e==>$e");
      updateLoader(false);
      _addNewsCategoriesApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
