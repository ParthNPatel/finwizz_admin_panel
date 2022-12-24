import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/connect_us_repo.dart';
import 'package:finwizz_admin/Model/Response_model/connect_us_res_model.dart';
import 'package:get/get.dart';

class ConnectUsViewModel extends GetxController {
  bool catchError = false;
  bool loader = false;
  int totalData = 0;
  updateLoader(val) {
    loader = val;
    update();
  }

  updateError(val) {
    catchError = val;
    update();
  }

  ApiResponse _connectUsApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get connectUsApiResponse => _connectUsApiResponse;

  Future<void> connectUsViewModel(
      {bool isLoading = true, int? limit, int? page}) async {
    if (isLoading) {
      _connectUsApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      ConnectUsResponseModel response =
          await ConnectUsRepo().connectUsRepo(page: page!, limit: limit);
      totalData = response.data!.total!;
      update();

      print("ConnectUsResponseModel=response==>${response.data!.total}");

      _connectUsApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("ConnectUsResponseModel=e==>$e");
      _connectUsApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
