import 'package:finwizz_admin/Model/Response_model/add_movers_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';

class AddMoversRepo {
  var headers = {'Content-Type': 'application/json'};
  Future<AddMoversResponseModel> addMoversRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: ApiUrl.addMovers,
        body: body,
        apitype: APIType.aPost,
        header: headers);
    print('AddCompanyResponseModel $response');
    AddMoversResponseModel addMoversResponseModel =
        AddMoversResponseModel.fromJson(response);
    print('AddMoversResponseModel $response');
    return addMoversResponseModel;
  }
}
