import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/get_movers_repo.dart';
import 'package:get/get.dart';

class GetMoversViewModel extends GetxController {
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

  dynamic moversData;
  ApiResponse _getMoversApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getMoversApiResponse => _getMoversApiResponse;

  Future<void> getMoversViewModel({bool isLoading = true}) async {
    updateError(true);
    if (isLoading) {
      _getMoversApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      moversData = await GetMoversRepo().getMoversRepo();
      // print("GetMoversResponseModel=response==>$moversData");

      _getMoversApiResponse = ApiResponse.complete(moversData);
      updateError(false);
    } catch (e) {
      print("GetMoversResponseModel=e==>$e");
      updateError(true);

      _getMoversApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
