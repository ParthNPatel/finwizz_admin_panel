import 'package:finwizz_admin/Model/Response_model/add_news_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';

class AddNewsRepo {
  var headers = {'Content-Type': 'application/json'};
  Future<AddNewsResponseModel> addNewsRepo({Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: ApiUrl.addNews,
        body: body,
        apitype: APIType.aPost,
        header: headers);
    AddNewsResponseModel addNewsResponseModel =
        AddNewsResponseModel.fromJson(response);
    print('AddNewsResponseModel $response');
    return addNewsResponseModel;
  }
}
