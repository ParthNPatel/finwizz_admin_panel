import 'package:finwizz_admin/Model/Response_model/get_news_cetegories_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';

class GetNewsCategoriesRepo {
  Future<GetNewsCategoriesResponseModel> getNewsCategoriesRepo() async {
    var response = await APIService().getResponse(
      url: ApiUrl.getNewsCategories,
      apitype: APIType.aGet,
    );
    GetNewsCategoriesResponseModel getNewsCategoriesResponseModel =
        GetNewsCategoriesResponseModel.fromJson(response);
    print('GetNewsCategoriesResponseModel $response');
    return getNewsCategoriesResponseModel;
  }
}
