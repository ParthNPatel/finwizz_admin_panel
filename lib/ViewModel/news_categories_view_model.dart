import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/get_news_categories_repo.dart';
import 'package:finwizz_admin/Model/Response_model/get_news_cetegories_res_model.dart';
import 'package:get/get.dart';

class GetNewsCategoriesViewModel extends GetxController {
  bool catchError = false;
  bool loader = false;
  int selectedCategories = 0;
  dynamic selectedValue;
  // bool changeData = false;

  // updateChangeValue(val) {
  //   changeData = val;
  //   update();
  // }

  updateValue(val) {
    selectedValue = val;
    update();
  }

  updateCategories(int index) {
    selectedCategories = index;
    update();
  }

  updateLoader(val) {
    loader = val;
    update();
  }

  updateError(val) {
    catchError = val;
    update();
  }

  ApiResponse _getNewsCategoriesApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getNewsCategoriesApiResponse => _getNewsCategoriesApiResponse;

  Future<void> getNewsCategoriesViewModel({
    bool isLoading = true,
  }) async {
    if (isLoading) {
      _getNewsCategoriesApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      GetNewsCategoriesResponseModel response =
          await GetNewsCategoriesRepo().getNewsCategoriesRepo();
      // print("GetNewsCategoriesResponseModel=response==>$response");

      _getNewsCategoriesApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetNewsCategoriesResponseModel=e==>$e");
      _getNewsCategoriesApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  @override
  void onInit() {
    // getVideoViewModel();
    super.onInit();
  }
}
