import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/insider_repo.dart';
import 'package:finwizz_admin/Model/Response_model/add_insider_res_model.dart';
import 'package:get/get.dart';

class InsiderViewModel extends GetxController {
  dynamic insiderData;

  bool catchError = false;
  bool loader = false;

  updateLoader(val) {
    loader = val;
    update();
  }

  updateError(val) {
    catchError = val;
    update();
  }

  ApiResponse _addInsiderApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addInsiderApiResponse => _addInsiderApiResponse;

  Future<void> addInsiderViewModel(
      {bool isLoading = true, Map<String, dynamic>? model}) async {
    if (isLoading) {
      _addInsiderApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      AddInsiderResponseModel response =
          await InsiderRepo().addInsiderRepo(body: model);
      log("AddInsiderResponseModel=response==>$response");

      _addInsiderApiResponse = ApiResponse.complete(response);
    } catch (e) {
      log("AddNewsResponseModel=e==>$e");
      _addInsiderApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// get Insider

  ApiResponse _getInsiderApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getInsiderApiResponse => _getInsiderApiResponse;

  Future<void> getInsiderViewModel({bool isLoading = true}) async {
    updateError(true);
    if (isLoading) {
      _getInsiderApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      insiderData = await InsiderRepo().getInsiderRepo();
      print("GetInsiderResponseModel=response==>$insiderData");

      _getInsiderApiResponse = ApiResponse.complete(insiderData);
      updateError(false);
    } catch (e) {
      print("GetMoversResponseModel=e==>$e");
      updateError(true);

      _getInsiderApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
