import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/get_news_repo.dart';
import 'package:get/get.dart';

class GetNewsViewModel extends GetxController {
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

  dynamic newsData;
  ApiResponse _getNewsApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getNewsApiResponse => _getNewsApiResponse;

  Future<void> getNewsViewModel({bool isLoading = true, String? id}) async {
    if (isLoading) {
      _getNewsApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      newsData = await GetNewsRepo().getNewsRepo(id: id);
      /*  print("GetNewsResponseModel=response==>${{
        (newsData['data'] as List).length
      }}");*/
      totalData = (newsData['data'] as List).length;
      update();
      _getNewsApiResponse = ApiResponse.complete(newsData);
    } catch (e) {
      print("GetNewsResponseModel=e==>$e");
      _getNewsApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  @override
  void onInit() {
    // getVideoViewModel();
    super.onInit();
  }
}
