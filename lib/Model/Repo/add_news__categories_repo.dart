import 'package:finwizz_admin/Model/Response_model/add_news_categories_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';

class AddNewsCategoriesRepo {
  var headers = {'Content-Type': 'application/json'};
  Future<AddNewsCategoriesResponseModel> addNewsCategoriesRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: ApiUrl.addNewsCategories,
        body: body,
        apitype: APIType.aPost,
        header: headers);
    AddNewsCategoriesResponseModel addNewsCategoriesResponseModel =
        AddNewsCategoriesResponseModel.fromJson(response);
    print('AddNewsCategoriesResponseModel $response');
    return addNewsCategoriesResponseModel;
  }
}
