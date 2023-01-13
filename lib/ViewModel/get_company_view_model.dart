import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/get_company_repo.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:get/get.dart';

class GetCompanyViewModel extends GetxController {
  bool catchError = false;
  int totalData = 0;
  dynamic selectedCompanyValue;
  updateValue(val) {
    selectedCompanyValue = val;
    update();
  }

  updateError(val) {
    catchError = val;
    update();
  }

  ApiResponse _getCompanyApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getCompanyApiResponse => _getCompanyApiResponse;

  Future<void> getCompanyViewModel(
      {bool isLoading = true, String? searchText = ""}) async {
    if (isLoading) {
      _getCompanyApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      GetCompanyResponseModel response =
          await GetCompanyRepo().getCompanyRepo(text: searchText);
      // print("GetCompanyResponseModel=response==>${response.data!.length}");
      totalData = response.data!.length;
      update();

      _getCompanyApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetCompanyResponseModel=e==>$e");
      _getCompanyApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
