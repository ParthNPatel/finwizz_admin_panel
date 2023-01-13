import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/add_company_repo.dart';
import 'package:finwizz_admin/Model/Response_model/add_company_res_model.dart';
import 'package:get/get.dart';

class AddCompanyViewModel extends GetxController {
  bool loader = false;

  updateLoader(val) {
    loader = val;
    update();
  }

  ApiResponse _addCompanyApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addCompanyApiResponse => _addCompanyApiResponse;

  Future<void> addCompanyViewModel(
      {bool isLoading = true, Map<String, dynamic>? model}) async {
    updateLoader(true);
    if (isLoading) {
      _addCompanyApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      AddCompanyResponseModel response =
          await AddCompanyRepo().addCompanyRepo(body: model);
      // log("AddCompanyResponseModel=response==>$response");

      _addCompanyApiResponse = ApiResponse.complete(response);
      updateLoader(false);
    } catch (e) {
      log("AddCompanyResponseModel=e==>$e");
      updateLoader(false);
      _addCompanyApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
