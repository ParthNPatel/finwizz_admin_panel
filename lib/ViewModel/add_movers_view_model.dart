import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/add_movers_repo.dart';
import 'package:finwizz_admin/Model/Response_model/add_movers_res_model.dart';
import 'package:get/get.dart';

class AddMoversViewModel extends GetxController {
  bool loader = false;

  updateLoader(val) {
    loader = val;
    update();
  }

  ApiResponse _addMoversApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addMoversApiResponse => _addMoversApiResponse;

  Future<void> addMoversViewModel(
      {bool isLoading = true, Map<String, dynamic>? model}) async {
    updateLoader(true);
    if (isLoading) {
      _addMoversApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      AddMoversResponseModel response =
          await AddMoversRepo().addMoversRepo(body: model);
      log("AddMoversResponseModel=response==>$response");

      _addMoversApiResponse = ApiResponse.complete(response);
      updateLoader(false);
    } catch (e) {
      log("AddMoversResponseModel=e==>$e");
      updateLoader(false);
      _addMoversApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
