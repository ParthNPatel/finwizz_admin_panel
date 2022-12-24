import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/add_news_repo.dart';
import 'package:finwizz_admin/Model/Response_model/add_news_res_model.dart';
import 'package:get/get.dart';

class AddNewsViewModel extends GetxController {
  bool loader = false;

  updateLoader(val) {
    loader = val;
    update();
  }

  ApiResponse _addNewsApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addNewsApiResponse => _addNewsApiResponse;

  Future<void> addNewsViewModel(
      {bool isLoading = true, Map<String, dynamic>? model}) async {
    updateLoader(true);
    if (isLoading) {
      _addNewsApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      AddNewsResponseModel response =
          await AddNewsRepo().addNewsRepo(body: model);
      log("AddNewsResponseModel=response==>$response");

      _addNewsApiResponse = ApiResponse.complete(response);
      updateLoader(false);
    } catch (e) {
      log("AddNewsResponseModel=e==>$e");
      updateLoader(false);
      _addNewsApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
