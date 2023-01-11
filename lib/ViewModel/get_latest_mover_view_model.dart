import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/get_latest_movers_repo.dart';
import 'package:get/get.dart';

class GetLatestMoverViewModel extends GetxController {
  dynamic latestMoverData;
  dynamic addLatestMoverData;
  ApiResponse _getLatestMoverApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getLatestMoverApiResponse => _getLatestMoverApiResponse;

  Future<void> getLatestMoversViewModel({
    bool isLoading = true,
  }) async {
    if (isLoading) {
      _getLatestMoverApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      latestMoverData = await GetLatestMoversRepo().getLatestMoversRepo();
      // print("searchNewsData=response==>$searchNewsData");

      _getLatestMoverApiResponse = ApiResponse.complete(latestMoverData);
    } catch (e) {
      print("searchNewsData=e==>$e");
      _getLatestMoverApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// LATEST MOVERS ADD
  ApiResponse _addLatestMoverApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addLatestMoverApiResponse => _addLatestMoverApiResponse;

  Future<void> addLatestMoversViewModel(
      {bool isLoading = true, Map<String, dynamic>? body}) async {
    if (isLoading) {
      _addLatestMoverApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      addLatestMoverData =
          await GetLatestMoversRepo().addLatestMoversRepo(body: body);
      print("addLatestMoverData=response==>$addLatestMoverData");

      _addLatestMoverApiResponse = ApiResponse.complete(addLatestMoverData);
    } catch (e) {
      print("addLatestMoverData=e==>$e");
      _addLatestMoverApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
